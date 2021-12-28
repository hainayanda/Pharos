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
    func ignore(_ exception: RelayException = .always, ifTrue shouldIgnore: @escaping (Changes<Observed>) -> Bool) -> ValueRelay<Observed> {
        let ignoreRelay = IgnoreRelay(currentValue: currentValue, exception: exception, ignoring: shouldIgnore)
        add(observer: ignoreRelay)
        return ignoreRelay
    }
}

public extension TransportRelay where Observed: AnyObject {
    func ignoreSameInstance(_ exception: RelayException = .always) -> ValueRelay<Observed> {
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
    func addDidUniqueInstanceSet(_ exception: RelayException = .always, _ consume: @escaping (Changes<Observed>) -> Void) -> ValueRelay<Observed> {
        ignoreSameInstance(exception).whenDidSet(then: consume)
    }
}

public extension TransportRelay where Observed: Equatable {
    
    func ignoreSameValue(_ exception: RelayException = .always) -> ValueRelay<Observed> {
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
    func addDidUniqueSet(_ exception: RelayException = .always, _ consume: @escaping (Changes<Observed>) -> Void) -> ValueRelay<Observed> {
        ignoreSameValue(exception).whenDidSet(then: consume)
    }
}

final class IgnoreRelay<Value>: ValueRelay<Value> {
    
    typealias Observed = Value
    typealias Ignorer = (Changes<Value>) -> Bool
    
    var ignoring: Ignorer = { _ in false }
    var exception: RelayException
    
    init(currentValue: RelayValue<Value>, exception: RelayException, ignoring: @escaping Ignorer) {
        self.exception = exception
        self.ignoring = ignoring
        super.init(currentValue: currentValue)
    }
    
    @discardableResult
    override func relay(changes: Changes<Value>) -> Bool {
        guard !shouldIgnore(changes: changes) else { return false }
        return super.relay(changes: changes)
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
