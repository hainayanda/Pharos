//
//  MappedRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public extension ObservableRelay {
    func map<Mapped>(_ mapper: @escaping (Observed) -> Mapped) -> MappedRelay<Observed, Mapped> {
        let mappedRelay = MappedRelay(value: currentValue, mapper: mapper)
        relayNotification(to: mappedRelay)
        return mappedRelay
    }
}

public class MappedRelay<Value, Mapped>: BaseRelay<Value>, ObservableRelay {
    
    public typealias Mapper = (Value) -> Mapped
    public typealias Observed = Mapped
    
    public internal(set) var currentValue: Mapped
    
    var relayDispatch: RelayDispatchHandler<Mapped> = .init()
    var nextRelays: Set<BaseRelay<Mapped>> = Set()
    let mapper: Mapper
    
    init(value: Value, mapper: @escaping Mapper) {
        self.currentValue = mapper(value)
        self.mapper = mapper
    }
    
    public override func relay(changes: Changes<Value>) {
        let mappedChanges = changes.map(mapper)
        currentValue = mappedChanges.new
        relayDispatch.relay(changes: mappedChanges)
        nextRelays.forEach { relay in
            relay.relay(changes: mappedChanges)
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
    
    public func nextRelay() -> ValueRelay<Mapped> {
        return ValueRelay<Mapped>(currentValue: currentValue)
    }
    
    public func invokeRelay() {
        let changes: Changes<Mapped> = .init(old: currentValue, new: currentValue, source: self)
        relayDispatch.relay(changes: changes)
        nextRelays.forEach { relay in
            relay.relay(changes: changes)
        }
    }
    
    public override func removeAllNextRelays() {
        nextRelays.forEach { $0.removeAllNextRelays() }
        nextRelays.removeAll()
    }
    
    @discardableResult
    public func relayNotification(to relay: BaseRelay<Mapped>) -> Self {
        nextRelays.insert(relay)
        return self
    }
}
