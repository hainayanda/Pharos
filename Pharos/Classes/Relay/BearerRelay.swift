//
//  BearerRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 19/06/21.
//

import Foundation

open class BearerRelay<Value>: BaseRelay<Value>, TransportRelay {
    
    public typealias Observed = Value
    
    public internal(set) var currentValue: Value
    var relayDispatch: RelayDispatchHandler<Value> = .init()
    var nextRelays: Set<BaseRelay<Value>> = Set()
    var ignoring: Ignorer = { _ in false }
    open override var isValid: Bool {
        relayDispatch.consumer != nil
    }
    
    public init(currentValue: Value, consumer: ((Changes<Value>) -> Void)?) {
        self.currentValue = currentValue
        self.relayDispatch.consumer = consumer
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
    
    public func invokeRelay() {
        relay(changes: .init(old: currentValue, new: currentValue, source: self))
    }
    
    public override func removeAllNextRelays() {
        nextRelays.forEach { $0.removeAllNextRelays() }
        nextRelays.removeAll()
    }
    
    @discardableResult
    public func addNext<Relay: BaseRelay<Value>>(relay: Relay) -> Relay {
        nextRelays.insert(relay)
        return relay
    }
    
    public override func discard() {
        relayDispatch.consumer = nil
    }
}
