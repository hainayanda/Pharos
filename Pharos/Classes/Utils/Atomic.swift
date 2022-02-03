//
//  Atomic.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

@propertyWrapper
struct Atomic<Wrapped> {
    private var lock: NSLock = NSLock()
    private var _wrappedValue: Wrapped
    var wrappedValue: Wrapped {
        get {
            lock.lock()
            defer { lock.unlock() }
            return _wrappedValue
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            _wrappedValue = newValue
        }
    }
    
    init(wrappedValue: Wrapped) {
        self._wrappedValue = wrappedValue
    }
    
}
