//
//  NextRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

open class BaseRelay<Value>: RelayHandler, Discardable, Hashable {
    
    public private(set) var retainerCount: Int = 0
    
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
    
    public func retained() {
        retainerCount += 1
    }
    
    public func unretained() {
        retainerCount -= 1
        if retainerCount <= 0 {
            discard()
        }
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
