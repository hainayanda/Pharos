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
        addNext(relay: mappedRelay)
        return mappedRelay
    }
}

public extension ObservableRelay where Observed: Collection {
    func compactMap<Mapped>(_ mapper: @escaping (Observed.Element) -> Mapped?) -> MappedRelay<Observed, [Mapped]> {
        map {
            $0.compactMap(mapper)
        }
    }
}

public class MappedRelay<Value, Mapped>: BaseRelay<Value>, ObservableRelay {
    
    public typealias Mapper = (Value) -> Mapped
    public typealias Observed = Mapped
    
    public internal(set) var currentValue: Mapped
    
    var relayDispatch: RelayDispatchHandler<Mapped> = .init()
    var nextRelays: Set<BaseRelay<Mapped>> = Set()
    let mapper: Mapper
    var ignoring: Ignorer = { _ in false }
    public override var isValid: Bool {
        relayDispatch.consumer != nil
    }
    
    init(value: Value, mapper: @escaping Mapper) {
        self.currentValue = mapper(value)
        self.mapper = mapper
    }
    
    @discardableResult
    public override func relay(changes: Changes<Value>) -> Bool {
        let mappedChanges = changes.map(mapper)
        guard !ignoring(mappedChanges) else { return false }
        currentValue = mappedChanges.new
        relayDispatch.relay(changes: mappedChanges)
        nextRelays.forEach { relay in
            relay.relay(changes: mappedChanges)
        }
        return true
    }
    
    @discardableResult
    public func whenDidSet(then consume: @escaping Consumer) -> Self {
        relayDispatch.consumer = consume
        return self
    }
    
    @discardableResult
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
    public func addNext<Relay: BaseRelay<Mapped>>(relay: Relay) -> Relay {
        nextRelays.insert(relay)
        return relay
    }
    
    public override func discard() {
        relayDispatch.consumer = nil
    }
}
