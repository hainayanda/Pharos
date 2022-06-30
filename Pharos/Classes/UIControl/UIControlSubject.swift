//
//  UIControlSubject.swift
//  Pharos
//
//  Created by Nayanda Haberty on 30/06/22.
//

import Foundation
#if canImport(UIKit)
import UIKit

@propertyWrapper
class UIControlSubject: Subject<UIControl.Event> {
    
    weak var sender: UIControl?
    
    public override var wrappedValue: UIControl.Event {
        get {
            super.wrappedValue
        }
        set {
            relay(
                changes: Changes(old: super.wrappedValue, new: newValue, source: sender ?? self),
                context: PharosContext()
            )
        }
    }
    
    override var projectedValue: BindableObservable<UIControl.Event> { self }
}
#endif
