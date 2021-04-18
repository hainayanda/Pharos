//
//  ValueRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

open class ValueRelay<Value>: BaseRelay<Value>, ObservableRelay {
    
    public typealias Observed = Value
    
    public internal(set) var currentValue: Value
    var relayDispatch: RelayDispatchHandler<Value> = .init()
    var nextRelays: Set<BaseRelay<Value>> = Set()
    var ignoring: Ignorer = { _ in false }
    
    public init(currentValue: Value) {
        self.currentValue = currentValue
    }
    
    @discardableResult
    open override func relay(changes: Changes<Value>) -> Bool {
        guard !ignoring(changes) else {
            return false
        }
        currentValue = changes.new
        relayDispatch.relay(changes: changes)
        nextRelays = nextRelays.filter {
            guard $0.isValid else { return false }
            $0.relay(changes: changes)
            return true
        }
        return true
    }
    
    @discardableResult
    public func whenDidSet(then consume: @escaping Consumer) -> Self {
        relayDispatch.consumer = consume
        return self
    }
    
    public func ignore(when ignoring: @escaping Ignorer) -> Self {
        self.ignoring = ignoring
        return self
    }
    
    @discardableResult
    public func multipleSetDelayed(by interval: TimeInterval) -> Self {
        relayDispatch.delay = interval
        return self
    }
    
    @discardableResult
    public func observe(on dispatcher: DispatchQueue) -> Self {
        relayDispatch.dispatcher = dispatcher
        return self
    }
    
    @discardableResult
    public func syncWhenInSameThread() -> Self {
        relayDispatch.syncIfPossible = true
        return self
    }
    
    public func nextRelay() -> ValueRelay<Value> {
        let nextRelay = ValueRelay<Value>(currentValue: currentValue)
        relayNotification(to: nextRelay)
        return nextRelay
    }
    
    public func invokeRelay() {
        relay(changes: .init(old: currentValue, new: currentValue, source: self))
    }
    
    public override func removeAllNextRelays() {
        nextRelays.forEach { $0.removeAllNextRelays() }
        nextRelays.removeAll()
    }
    
    @discardableResult
    public func relayNotification(to relay: BaseRelay<Value>) -> Self {
        nextRelays.insert(relay)
        return self
    }
}
