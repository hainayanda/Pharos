//
//  Atomic.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

@propertyWrapper
class Atomic<Wrapped> {
    private var dispatcher: DispatchQueue
    private var _wrappedValue: Wrapped
    var wrappedValue: Wrapped {
        get {
            dispatcher.safeSync {
                _wrappedValue
            }
        }
        set {
            dispatcher.safeSync {
                _wrappedValue = newValue
            }
        }
    }
    
    init(wrappedValue: Wrapped) {
        self.dispatcher = DispatchQueue(label: "Pharos_atomic_\(UUID().uuidString)")
        self._wrappedValue = wrappedValue
    }
    
    init(_ dispatcher: DispatchQueue, wrappedValue: Wrapped) {
        self.dispatcher = dispatcher
        self._wrappedValue = wrappedValue
    }
    
}
