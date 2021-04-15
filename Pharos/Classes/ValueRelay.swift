//
//  ValueRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public class ValueRelay<Value>: NextRelay<Value>, ObservableRelay {
    
    public typealias Observed = Value
    
    public internal(set) var currentValue: Value
    var relayDispatch: RelayDispatchHandler<Value> = .init()
    var nextRelays: Set<NextRelay<Value>> = Set()
    
    init(currentValue: Value) {
        self.currentValue = currentValue
    }
    
    override func relay(changes: Changes<Value>) {
        currentValue = changes.new
        relayDispatch.relay(changes: changes)
        nextRelays = nextRelays.filter {
            guard $0.isValid else { return false }
            $0.relay(changes: changes)
            return true
        }
    }
    
    @discardableResult
    public func whenDidSet(then consume: @escaping Consumer) -> Self {
        relayDispatch.consumer = consume
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
    
    public func addNext() -> ValueRelay<Value> {
        let nextRelay = ValueRelay<Value>(currentValue: currentValue)
        relayNotification(to: nextRelay)
        return nextRelay
    }
    
    public func addNext(with dereferencer: Dereferencer) -> ValueRelay<Value> {
        addNext().with(dereferencer: dereferencer)
    }
    
    public func invokeRelay() {
        relay(changes: .init(old: currentValue, new: currentValue, source: self))
    }
    
    public override func removeAllNextRelays() {
        nextRelays.forEach { $0.removeAllNextRelays() }
        nextRelays.removeAll()
    }
    
    @discardableResult
    public func relayNotification(to relay: NextRelay<Value>) -> Self {
        nextRelays.insert(relay)
        return self
    }
}
