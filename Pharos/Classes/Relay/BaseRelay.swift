//
//  NextRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

open class BaseRelay<Value>: RelayOperationHandler, Discardable, Hashable {
    
    open var isValid: Bool {
        fatalError("should overridden")
    }
    
    var uniqueKey: String = UUID().uuidString
    
    open func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueKey)
    }
    
    @discardableResult
    open func relay(changes: Changes<Value>) -> Bool {
        fatalError("should overridden")
    }
    
    @available(*, renamed: "referenceManaged")
    @discardableResult
    open func retained(by retainer: Retainer) -> Self {
        retainer.add(discardable: self)
        return self
    }
    
    open func discard() {
        fatalError("should overridden")
    }
    
    open func removeAllNextRelays() {
        fatalError("should overridden")
    }
    
    public static func == (lhs: BaseRelay<Value>, rhs: BaseRelay<Value>) -> Bool {
        lhs.uniqueKey == rhs.uniqueKey
    }
}
