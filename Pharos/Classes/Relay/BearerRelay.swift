//
//  BearerRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 19/06/21.
//

import Foundation

open class BearerRelay<Value>: BaseRelay<Value>, TransportRelay {
    
    public typealias Observed = Value
    
    public internal(set) var currentValue: RelayValue<Value>
    var relayDispatch: RelayChangeHandler<Value> = .init()
    var nextRelays: Set<BaseRelay<Value>> = Set()
    var ignoring: Ignorer = { _ in false }
    open override var isValid: Bool {
        relayDispatch.consumer != nil || !nextRelays.isEmpty
    }
    
    public init(currentValue: RelayValue<Value>, consumer: ((Changes<Value>) -> Void)?) {
        self.currentValue = currentValue
        self.relayDispatch.consumer = consumer
    }
    
    @discardableResult
    open override func relay(changes: Changes<Value>) -> Bool {
        guard !ignoring(changes) else {
            return false
        }
        currentValue = .value(changes.new)
        relayDispatch.relay(changes: changes)
        nextRelays = nextRelays.filter {
            guard $0.isValid else { return false }
            $0.relay(changes: changes)
            return true
        }
        return true
    }
    
    open func ignore(when ignoring: @escaping Ignorer) -> Self {
        self.ignoring = ignoring
        return self
    }
    
    @discardableResult
    open func multipleSetDelayed(by interval: TimeInterval) -> Self {
        relayDispatch.delay = interval
        return self
    }
    
    @discardableResult
    open func observe(on dispatcher: DispatchQueue) -> Self {
        relayDispatch.dispatcher = dispatcher
        return self
    }
    
    @discardableResult
    open func syncWhenInSameThread() -> Self {
        relayDispatch.syncIfPossible = true
        return self
    }
    
    open func invokeRelayWithCurrent() {
        guard let value = currentValue.value else { return }
        relay(changes: .init(old: currentValue, new: value, invokedManually: true, source: self))
    }
    
    open override func removeAllNextRelays() {
        nextRelays.cleanRelays()
    }
    
    @discardableResult
    open func add<Relay: BaseRelay<Value>>(observer: Relay) -> Relay {
        nextRelays.insert(observer)
        return observer
    }
    
    open override func discard() {
        relayDispatch.consumer = nil
        nextRelays.removeAll()
    }
}
