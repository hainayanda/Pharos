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
        _ keyPath: ReferenceWritableKeyPath<Object, Value>) -> AssociativeTwoWayRelay<Value> {
        TwoWayKVORelay<Object, Value>(object, keyPath: keyPath)
    }
}

class TwoWayKVORelay<Object: NSObject, Value>: AssociativeTwoWayRelay<Value> {
    
    typealias Observed = Value
    
    var object: Object? {
        associatedObject as? Object
    }
    let keyPath: ReferenceWritableKeyPath<Object, Value>
    var token: Any?
    var textToken: Any?
    var relayedFromOutside: Bool = false
    
    init(_ object: Object, keyPath: ReferenceWritableKeyPath<Object, Value>) {
        self.keyPath = keyPath
        super.init(object, currentValue: object[keyPath: keyPath])
        bond(with: object)
    }
    
    @discardableResult
    override func relay(changes: Changes<Value>) -> Bool {
        guard let object = object,
              changes.source as? Object != object else {
            return super.relay(changes: changes)
        }
        self.relayedFromOutside = true
        object[keyPath: keyPath] = changes.new
        return super.relay(changes: changes)
    }
    
    func bond(with object: Object) {
        #if canImport(UIKit)
        if let field = object as? UITextInput,
           keyPath == \UITextView.text || keyPath == \UITextField.text {
            textToken = observeText(of: field)
        } else if let searchBar = object as? UISearchBar, keyPath == \UISearchBar.text {
            textToken = observeText(of: searchBar.textField)
        }
        #endif
        token = observeChange(object: object, keyPath)
    }
    
    func observeChange<Object: NSObject, PathValue>(object: Object, _ keyPath: ReferenceWritableKeyPath<Object, PathValue>) -> NSObjectProtocol {
        object.observe(keyPath, options: [.new, .old]) { [weak self] object, kvoChanges in
            guard let self = self else { return }
            guard !self.relayedFromOutside,
                  let old: Value = kvoChanges.oldValue as? Value,
                  let new = kvoChanges.newValue as? Value else {
                self.relayedFromOutside = false
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
            guard !self.relayedFromOutside,
                  let textInput = textInput,
                  let textRange = textInput.textRange(from: textInput.beginningOfDocument, to: textInput.endOfDocument),
                  let newValue: Value = (
                    textInput.text(in: textRange) as? Value
                        ?? Optional<String>(nilLiteral: ()) as? Value) else {
                self.relayedFromOutside = false
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
