//
//  Observable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

@propertyWrapper
public class Subject<Observed>: BindableObservable<Observed> {
    
    var _wrappedValue: Observed
    public var wrappedValue: Observed {
        get {
            _wrappedValue
        }
        set {
            let oldValue = _wrappedValue
            _wrappedValue = newValue
            relay(changes: Changes(old: oldValue, new: newValue, source: self))
        }
    }
    
    override var recentState: Observed? {
        _wrappedValue
    }
    
    public init(wrappedValue: Observed) {
        self._wrappedValue = wrappedValue
        super.init()
        self.callBack = { [weak self] changes in
            self?._wrappedValue = changes.new
        }
    }
}
