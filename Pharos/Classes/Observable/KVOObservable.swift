//
//  KVOObservable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

final class KVOObservable<Object: NSObject, Property>: BufferedObservable<Property> {
    weak var object: Object?
    let keyPath: KeyPath<Object, Property>
    var retainedContext: NSKeyValueObservation?
    var latestKeyPathSet: Changes<Property>?
    @inlinable var recentState: Property? { object?[keyPath: keyPath] }
    
    @inlinable init(_ object: Object, _ keyPath: KeyPath<Object, Property>) {
        self.object = object
        self.keyPath = keyPath
        super.init()
        nsObjectObserve(object, keyPath)
    }
    
    @inlinable func nsObjectObserve(_ object: Object, _ keyPath: KeyPath<Object, Property>) {
#if canImport(UIKit)
        if let field = object as? UITextInput,
           keyPath == \UITextView.text || keyPath == \UITextField.text {
            observeText(of: field)
        } else if let searchBar = object as? UISearchBar, keyPath == \UISearchBar.text {
            observeText(of: searchBar.textField)
        }
#endif
        observeChange(object: object, keyPath)
    }
    
    @inlinable func observeChange(object: Object, _ keyPath: KeyPath<Object, Property>) {
        self.retainedContext = object.observe(keyPath, options: [.old, .new]) { [weak self] _, kvoChanges in
            guard let self = self else { return }
            guard let newValue = kvoChanges.newValue else { return }
            let changes = self.latestKeyPathSet ?? Changes(new: newValue, old: kvoChanges.oldValue)
            self.latestKeyPathSet = nil
            guard changes.canBeConsumed(by: self) else { return }
            self.send(changes: changes.consumed(by: self))
        }
    }
    
    @discardableResult
    @inlinable override func accept(_ changes: Changes<Property>) -> Bool {
        guard super.accept(changes) else { return false }
        guard let writableKeypath = keyPath as? WritableKeyPath<Object, Property> else {
            return true
        }
        latestKeyPathSet = changes
        object?[keyPath: writableKeypath] = changes.new
        return true
    }
    
#if canImport(UIKit)
    @inlinable func observeText(of textInput: UITextInput) {
        let notificationName: NSNotification.Name = textInput is UITextField ?
        UITextField.textDidChangeNotification : UITextView.textDidChangeNotification
        if let textRange = textInput.textRange(from: textInput.beginningOfDocument, to: textInput.endOfDocument),
           let latestState = textInput.text(in: textRange) as? Property {
            self.buffer = latestState
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textNotification(_:)),
            name: notificationName,
            object: textInput
        )
    }
    
    @objc @inlinable func textNotification(_ notification: Notification) {
        guard let textInput = notification.object as? UITextInput,
              let textRange = textInput.textRange(from: textInput.beginningOfDocument, to: textInput.endOfDocument),
              let new = textInput.text(in: textRange) as? Property else {
                  return
              }
        let old = buffer
        buffer = new
        let changes = latestKeyPathSet ?? Changes(new: new, old: old)
        latestKeyPathSet = nil
        guard changes.canBeConsumed(by: self) else { return }
        self.send(changes: changes.consumed(by: self))
    }
#endif
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

#if canImport(UIKit)
extension UISearchBar {
    
    @inlinable var textField: UITextField {
        if #available(iOS 13, *) {
            return searchTextField
        } else {
            // swiftlint:disable:next force_cast
            return self.value(forKey: "_searchField") as! UITextField
        }
    }
    
}
#endif
