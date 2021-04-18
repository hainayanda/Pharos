//
//  NextRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

open class BaseRelay<Value>: RelayOperationHandler, Hashable {
    
    var referenced: Bool = false
    weak var discardable: Discardable? {
        didSet {
            referenced = true
        }
    }
    
    var isValid: Bool { !isInvalid }
    
    var isInvalid: Bool { referenced && discardable?.discarded ?? true }
    
    var uniqueKey: String = UUID().uuidString
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueKey)
    }
    
    @discardableResult
    open func relay(changes: Changes<Value>) -> Bool {
        fatalError("should overridden")
    }
    
    open func referenceManaged(by dereferencer: Dereferencer) -> Self {
        dereferencer.add(discardable: makeDiscardable())
        return self
    }
    
    public func discard() {
        referenced = true
        discardable?.discard()
    }
    
    public func makeDiscardable() -> Discardable {
        let discardable = self.discardable ?? Discardable(content: self)
        self.discardable = discardable
        return discardable
    }
    
    open func removeAllNextRelays() {
        fatalError("should overridden")
    }
    
    public static func == (lhs: BaseRelay<Value>, rhs: BaseRelay<Value>) -> Bool {
        lhs.uniqueKey == rhs.uniqueKey
    }
}
