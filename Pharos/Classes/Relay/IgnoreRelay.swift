//
//  IgnoreRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 28/12/21.
//

import Foundation

public enum RelayException {
    case always
    case exceptInvokedManually
}

public extension TransportRelay {
    func ignore(_ exception: RelayException = .always, ifTrue shouldIgnore: @escaping IgnoreRelay<Observed>.Ignorer) -> IgnoreRelay<Observed> {
        let ignoreRelay = IgnoreRelay(value: currentValue, exception: exception, ignoring: shouldIgnore)
        add(observer: ignoreRelay)
        return ignoreRelay
    }
}

public extension TransportRelay where Observed: AnyObject {
    func ignoreSameInstance(_ exception: RelayException = .always) -> IgnoreRelay<Observed> {
        ignore(exception) { $0.isSameInstance }
    }
    
    @discardableResult
    func relayUniqueInstance(_ exception: RelayException = .always, to observer: TwoWayRelay<Observed>) -> TwoWayRelay<Observed> {
        ignoreSameInstance(exception).relayValue(to: observer)
    }
    
    @discardableResult
    func relayUniqueInstance(_ exception: RelayException = .always, to observer: BearerRelay<Observed>) -> BearerRelay<Observed> {
        ignoreSameInstance(exception).relayValue(to: observer)
    }
    
    @discardableResult
    func addDidUniqueInstanceSet(_ exception: RelayException = .always, _ consume: @escaping (Changes<Observed>) -> Void) -> IgnoreRelay<Observed> {
        ignoreSameInstance(exception).whenDidSet(then: consume)
    }
}

public extension TransportRelay where Observed: Equatable {
    
    func ignoreSameValue(_ exception: RelayException = .always) -> IgnoreRelay<Observed> {
        ignore(exception) { $0.isNotChanging }
    }
    
    @discardableResult
    func relayUniqueValue(_ exception: RelayException = .always, to observer: TwoWayRelay<Observed>) -> TwoWayRelay<Observed> {
        ignoreSameValue(exception).relayValue(to: observer)
    }
    
    @discardableResult
    func relayUniqueValue(_ exception: RelayException = .always, to observer: BearerRelay<Observed>) -> BearerRelay<Observed> {
        ignoreSameValue(exception).relayValue(to: observer)
    }
    
    @discardableResult
    func addDidUniqueSet(_ exception: RelayException = .always, _ consume: @escaping (Changes<Observed>) -> Void) -> IgnoreRelay<Observed> {
        ignoreSameValue(exception).whenDidSet(then: consume)
    }
}

public final class IgnoreRelay<Value>: BaseRelay<Value>, ObservableRelay {
    
    public typealias Observed = Value
    public typealias Ignorer = (Changes<Value>) -> Bool
    
    public internal(set) var currentValue: RelayValue<Value>
    
    var relayDispatch: RelayChangeHandler<Value> = .init()
    var nextRelays: Set<BaseRelay<Value>> = Set()
    var ignoring: Ignorer = { _ in false }
    var exception: RelayException
    public override var isValid: Bool {
        relayDispatch.consumer != nil || !nextRelays.isEmpty
    }
    
    init(value: RelayValue<Value>, exception: RelayException, ignoring: @escaping Ignorer) {
        self.exception = exception
        self.currentValue = value
        self.ignoring = ignoring
    }
    
    @discardableResult
    public override func relay(changes: Changes<Value>) -> Bool {
        guard !shouldIgnore(changes: changes) else { return false }
        currentValue = .value(changes.new)
        relayDispatch.relay(changes: changes)
        nextRelays.relayAndRemoveInvalid(changes: changes)
        return true
    }
    
    @discardableResult
    func whenDidSet(then consume: @escaping Consumer) -> Self {
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
    
    public func invokeRelayWithCurrent() {
        guard let value = currentValue.value else {
            return
        }
        let changes: Changes<Value> = .init(old: currentValue, new: value, invokedManually: true, source: self)
        relayDispatch.relay(changes: changes)
        nextRelays.relayAndRemoveInvalid(changes: changes)
    }
    
    public override func removeAllNextRelays() {
        nextRelays.cleanRelays()
    }
    
    @discardableResult
    public func add<Relay: BaseRelay<Value>>(observer: Relay) -> Relay {
        nextRelays.insert(observer)
        return observer
    }
    
    public override func discard() {
        relayDispatch.consumer = nil
        nextRelays.removeAll()
    }
    
    func shouldIgnore(changes: Changes<Value>) -> Bool {
        switch exception {
        case .always:
            return ignoring(changes)
        case .exceptInvokedManually:
            guard changes.invokedManually else {
                return ignoring(changes)
            }
            return false
        }
    }
}
