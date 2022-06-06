//
//  BindableKVO.swift
//  Pharos
//
//  Created by Nayanda Haberty on 16/04/21.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

enum KVOSource {
    case property
    case external
    case none
}

final class BindableKVOObservable<Object: NSObject, Observed>: BindableObservable<Observed> {
    var token: NSObjectProtocol?
    var recentSource: KVOSource = .none
    var latestValue: Observed?
    weak var object: Object?
    let keyPath: ReferenceWritableKeyPath<Object, Observed>
    
    override var recentState: Observed? {
        object?[keyPath: keyPath]
    }
    
    init(object: Object, keyPath: ReferenceWritableKeyPath<Object, Observed>) {
        self.keyPath = keyPath
        self.object = object
        super.init(retainer: ContextRetainer()) { [weak object] changes in
            guard let object = object else {
                return
            }
            object[keyPath: keyPath] = changes.new
        }
        kvoBind(with: object, keyPath: keyPath)
    }
    
    override func relay(changes: Changes<Observed>, context: PharosContext) {
        recentSource = changes.source as? Object === object ? .property : .external
        switch recentSource {
        case .property:
            super.superRelay(changes, context)
            self.recentSource = .none
        case .external:
            super.callCallback(changes)
            super.superRelay(changes, context)
        case .none:
            return
        }
    }
    
    func kvoBind(with object: Object, keyPath: ReferenceWritableKeyPath<Object, Observed>) {
#if canImport(UIKit)
        if let field = object as? UITextInput,
           keyPath == \UITextView.text || keyPath == \UITextField.text {
            observeText(of: field)
        } else if let searchBar = object as? UISearchBar, keyPath == \UISearchBar.text {
            observeText(of: searchBar.textField)
        }
#endif
        token = observeChange(object: object, keyPath)
    }
    
    func observeChange<Object: NSObject>(object: Object, _ keyPath: ReferenceWritableKeyPath<Object, Observed>) -> NSObjectProtocol {
        object.observe(keyPath, options: [.new, .old]) { [weak self] object, kvoChanges in
            guard let self = self else { return }
            let old = kvoChanges.oldValue
            guard let new: Observed = kvoChanges.newValue else {
                return
            }
            switch self.recentSource {
            case .property, .external:
                self.recentSource = .none
                return
            case .none:
                guard let source = self.object else { return }
                self.relay(
                    changes: Changes(old: old, new: new, source: source),
                    context: PharosContext()
                )
            }
        }
    }
    
#if canImport(UIKit)
    func observeText(of textInput: UITextInput) {
        let notificationName: NSNotification.Name = textInput is UITextField ?
        UITextField.textDidChangeNotification : UITextView.textDidChangeNotification
        if let textRange = textInput.textRange(from: textInput.beginningOfDocument, to: textInput.endOfDocument),
           let latestValue = textInput.text(in: textRange) as? State {
            self.latestValue = latestValue
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textNotification(_:)),
            name: notificationName,
            object: textInput
        )
    }
    
    @objc func textNotification(_ notification: Notification) {
        guard let textInput = notification.object as? UITextInput,
              let textRange = textInput.textRange(from: textInput.beginningOfDocument, to: textInput.endOfDocument),
              let new = textInput.text(in: textRange) as? State else {
                  return
              }
        let old = latestValue
        latestValue = new
        switch self.recentSource {
        case .property, .external:
            self.recentSource = .none
            return
        case .none:
            guard let source = self.object else { return }
            self.relay(
                changes: Changes(old: old, new: new, source: source),
                context: PharosContext()
            )
        }
    }
#endif
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

#if canImport(UIKit)
extension UISearchBar {
    
    var textField: UITextField {
        if #available(iOS 13, *) {
            return searchTextField
        } else {
            return self.value(forKey: "_searchField") as! UITextField
        }
    }
    
}
#endif
