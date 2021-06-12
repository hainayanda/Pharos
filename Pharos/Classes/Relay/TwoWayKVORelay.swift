//
//  TwoWayKVORelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 16/04/21.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

public extension TwoWayRelay {
    static func relay<Object: NSObject, Value>(
        of object: Object,
        _ keyPath: ReferenceWritableKeyPath<Object, Value>,
        dereferencedBy dereferencer: Dereferencer? = nil) -> TwoWayRelay<Value> {
        TwoWayKVORelay<Object, Value>(object, keyPath: keyPath)
    }
}

public class TwoWayKVORelay<Object: NSObject, Value>: TwoWayRelay<Value> {
    
    public typealias Observed = Value
    
    weak var object: Object?
    let keyPath: ReferenceWritableKeyPath<Object, Value>
    var token: Any?
    var outsideInvoked: Bool = false
    
    init(_ object: Object, keyPath: ReferenceWritableKeyPath<Object, Value>) {
        self.object = object
        self.keyPath = keyPath
        super.init(currentValue: object[keyPath: keyPath])
        self.token = bond(with: object)
    }
    
    @discardableResult
    public override func relay(changes: Changes<Value>) -> Bool {
        guard let object = object,
              changes.source as? Object != object,
              !ignoring(changes) else { return false }
        self.outsideInvoked = true
        object[keyPath: keyPath] = changes.new
        super.relay(changes: changes)
        return true
    }
    
    @discardableResult
    public func bond(with object: Object) -> Any {
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
        return token
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
}
