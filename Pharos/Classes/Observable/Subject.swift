//
//  Observable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

@propertyWrapper
public final class Subject<Wrapped>: BindableObservable<Wrapped> {
    
    var _wrappedValue: Wrapped
    public var wrappedValue: Wrapped {
        get {
            _wrappedValue
        }
        set {
            let oldValue = _wrappedValue
            _wrappedValue = newValue
            relay(
                changes: Changes(old: oldValue, new: newValue, source: self),
                context: PharosContext()
            )
        }
    }
    
    public var projectedValue: BindableObservable<Wrapped> {
        self
    }
    
    override var recentState: Wrapped? {
        _wrappedValue
    }
    
    public init(wrappedValue: Wrapped) {
        self._wrappedValue = wrappedValue
        super.init(retainer: ContextRetainer())
        self.callBack = { [weak self] changes in
            self?._wrappedValue = changes.new
        }
    }
}
