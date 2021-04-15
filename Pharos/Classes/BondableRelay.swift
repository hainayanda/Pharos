//
//  BondableRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

public class BondableRelay<Value>: ValueRelay<Value> {
    
    let backRelay: Consumer
    var bondingRelay: NextRelay<Value>?
    var outsideInvoked: Bool = false
    
    init(currentValue: Value, backRelay: @escaping Consumer) {
        self.backRelay = backRelay
        super.init(currentValue: currentValue)
    }
    
    override func relay(changes: Changes<Value>) {
        super.relay(changes: changes)
        bondingRelay?.relay(changes: changes)
    }
    
    func relayBack(changes: Changes<Value>) {
        backRelay(changes)
    }
    
    @discardableResult
    public func bondAndApply<Object: NSObject>(to object: Object, _ keyPath: ReferenceWritableKeyPath<Object, Value>) -> ValueRelay<Value> {
        object[keyPath: keyPath] = currentValue
        return bond(with: object, keyPath)
    }
    
    @discardableResult
    public func bondAndMap<Object: NSObject>(from object: Object, _ keyPath: ReferenceWritableKeyPath<Object, Value>) -> ValueRelay<Value> {
        relayBack(
            changes: .init(
                old: currentValue,
                new: object[keyPath: keyPath],
                source: object
            )
        )
        return bond(with: object, keyPath)
    }
    
    @discardableResult
    public func bond<Object: NSObject>(with object: Object, _ keyPath: ReferenceWritableKeyPath<Object, Value>) -> ValueRelay<Value> {
        let token: Any
        #if canImport(UIKit)
        if let field = object as? UITextInput,
           keyPath == \UITextView.text || keyPath == \UITextField.text {
            token = observeText(of: field)
        } else if let searchBar = object as? UISearchBar, keyPath == \UISearchBar.text {
            token = observeText(of: searchBar.textField)
        } else {
            token = observeChange(object: object, keyPath)
        }
        #else
        token = observeChange(object: object, keyPath)
        #endif
        bondingRelay = ClosureRelay(retained: token) { [weak self, weak object] changes in
            guard let self = self,
                  let object = object, changes.source as? Object != object else { return }
            self.outsideInvoked = true
            object[keyPath: keyPath] = changes.new
        }
        return addNext()
    }
    
    func observeChange<Object: NSObject, PathValue>(object: Object, _ keyPath: ReferenceWritableKeyPath<Object, PathValue>) -> NSObjectProtocol {
        object.observe(keyPath, options: [.new, .old]) { [weak self] object, kvoChanges in
            guard let self = self else { return }
            guard !self.outsideInvoked,
                  let old: Value = kvoChanges.oldValue as? Value,
                  let new = kvoChanges.newValue as? Value else {
                self.outsideInvoked = false
                return
            }
            self.relayBack(
                changes: .init(
                    old: old,
                    new: new,
                    source: object
                )
            )
        }
    }
    
    #if canImport(UIKit)
    func observeText(of textInput: UITextInput) -> NSObjectProtocol {
        let notificationName: NSNotification.Name = textInput is UITextField ?
            UITextField.textDidChangeNotification : UITextView.textDidChangeNotification
        return NotificationCenter.default.addObserver(forName: notificationName, object: textInput, queue: nil) { [weak self, weak textInput] _ in
            guard let self = self else { return }
            guard !self.outsideInvoked,
                  let textInput = textInput,
                  let textRange = textInput.textRange(from: textInput.beginningOfDocument, to: textInput.endOfDocument),
                  let newValue: Value = (
                    textInput.text(in: textRange) as? Value
                        ?? Optional<String>(nilLiteral: ()) as? Value) else {
                self.outsideInvoked = false
                return
            }
            self.relayBack(
                changes: .init(
                    old: self.currentValue,
                    new: newValue,
                    source: textInput
                )
            )
        }
    }
    #endif
    
    public override func removeAllNextRelays() {
        super.removeAllNextRelays()
        bondingRelay = nil
    }
}
