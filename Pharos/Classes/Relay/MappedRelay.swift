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
        add(observer: mappedRelay)
        return mappedRelay
    }
    
    func compactMap<Mapped>(_ mapper: @escaping (Observed) throws -> Mapped?) -> MappedRelay<Observed, Mapped> {
        let mappedRelay = MappedRelay(value: currentValue, mapper: mapper)
        add(observer: mappedRelay)
        return mappedRelay
    }
}

public extension ObservableRelay where Observed: Collection {
    @available(*, renamed: "compactMap")
    func listMap<Mapped>(_ mapper: @escaping (Observed.Element) -> Mapped?) -> MappedRelay<Observed, [Mapped]> {
        map {
            $0.compactMap(mapper)
        }
    }
}

public final class MappedRelay<Value, Mapped>: BaseRelay<Value>, ObservableRelay {
    
    public typealias Mapper = (Value) throws -> Mapped?
    public typealias Observed = Mapped
    
    internal var _currentValue: Mapped?
    public var currentValue: Mapped {
        guard let value = _currentValue else {
            fatalError("fail to map currentValue")
        }
        return value
    }
    
    var relayDispatch: RelayChangeHandler<Mapped> = .init()
    var nextRelays: Set<BaseRelay<Mapped>> = Set()
    let mapper: Mapper
    var ignoring: Ignorer = { _ in false }
    public override var isValid: Bool {
        relayDispatch.consumer != nil || !nextRelays.isEmpty
    }
    
    init(value: Value, mapper: @escaping Mapper) {
        self._currentValue = try? mapper(value)
        self.mapper = mapper
    }
    
    @discardableResult
    public override func relay(changes: Changes<Value>) -> Bool {
        guard let mappedChanges = changes.map(mapper),
              !ignoring(mappedChanges) else { return false }
        _currentValue = mappedChanges.new
        relayDispatch.relay(changes: mappedChanges)
        nextRelays.relay(changes: mappedChanges)
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
    
    public func invokeRelayWithCurrent() {
        guard let value = _currentValue else {
            return
        }
        let changes: Changes<Mapped> = .init(old: value, new: value, invokedManually: true, source: self)
        relayDispatch.relay(changes: changes)
        nextRelays.relay(changes: changes)
    }
    
    public override func removeAllNextRelays() {
        nextRelays.cleanRelays()
    }
    
    @discardableResult
    public func addNext<Relay: BaseRelay<Mapped>>(relay: Relay) -> Relay {
        nextRelays.insert(relay)
        return relay
    }
    
    public override func discard() {
        relayDispatch.consumer = nil
        nextRelays.removeAll()
    }
}
