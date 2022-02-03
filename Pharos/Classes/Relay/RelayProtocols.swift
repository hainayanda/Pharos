//
//  RelayProtocols.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

// MARK: ChangeObservable

public protocol ChangeObservable: MappableObservable, FilterableObservable, MergableObservable, CombinableObservable {
    associatedtype Observed
    
    func whenDidSet(thenDo work: @escaping (Changes<Observed>) -> Void) -> ObservedRelay<Observed>
    func relayChanges(to relay: BindableRelay<Observed>) -> ObservedRelay<Observed>
}

extension ChangeObservable {
    public func relayChanges(to relay: BindableRelay<Observed>) -> ObservedRelay<Observed> {
        whenDidSet { [weak relay] changes in
            guard let relay = relay else { return }
            if let selfRelay = self as? AnyRelay {
                relay.relay(changes: changes, skip: selfRelay)
            } else {
                relay.relay(changes: changes)
            }
        }
    }
}

// MARK: MappableObservable

public protocol MappableObservable {
    associatedtype Observed
    
    func mapped<Mapped>(_ mapper: @escaping (Observed) -> Mapped) -> ObservableValue<Mapped>
    func compactMapped<Mapped>(_ mapper: @escaping (Observed) throws -> Mapped?) -> ObservableValue<Mapped>
}

extension MappableObservable {
    public func mapped<Mapped>(_ mapper: @escaping (Observed) -> Mapped) -> ObservableValue<Mapped> {
        compactMapped(mapper)
    }
}

// MARK: FilterableObservable

public protocol FilterableObservable {
    associatedtype Observed
    
    func ignore(when shouldIgnore: @escaping (Changes<Observed>) -> Bool) -> ObservableValue<Observed>
    func onlyInclude(when shouldInclude: @escaping (Changes<Observed>) -> Bool) -> ObservableValue<Observed>
}

extension FilterableObservable {
    public func onlyInclude(when shouldInclude: @escaping (Changes<Observed>) -> Bool) -> ObservableValue<Observed> {
        ignore { changes in
            !shouldInclude(changes)
        }
    }
}

public extension FilterableObservable where Observed: Equatable {
    func ignoreSameValue() -> ObservableValue<Observed> {
        ignore { $0.isNotChanging }
    }
}

// MARK: MergableObservable

public protocol MergableObservable {
    associatedtype Observed
    
    func merge(with relays: ObservableValue<Observed>...) -> ObservableValue<Observed>
}

// MARK: CombinableObservable

public protocol CombinableObservable {
    associatedtype Observed
    
    func combine<Observed1>(with relay: ObservableValue<Observed1>) -> ObservableValue<(Observed?, Observed1?)>
    func combine<Observed1, Observed2>(
        with relay1: ObservableValue<Observed1>, _ relay2: ObservableValue<Observed2>
    ) -> ObservableValue<(Observed?, Observed1?, Observed2?)>
    func combine<Observed1, Observed2, Observed3>(
        with relay1: ObservableValue<Observed1>, _ relay2: ObservableValue<Observed2>, _ relay3: ObservableValue<Observed3>
    ) -> ObservableValue<(Observed?, Observed1?, Observed2?, Observed3?)>
}

public extension CombinableObservable {
    func compactCombine<Observed1>(with relay: ObservableValue<Observed1>) -> ObservableValue<(Observed, Observed1)> {
        combine(with: relay).compactMapped { combined in
            guard let first = combined.0, let second = combined.1 else { return nil }
            return (first, second)
        }
    }
    
    func compactCombine<Observed1, Observed2>(
        with relay1: ObservableValue<Observed1>, _ relay2: ObservableValue<Observed2>
    ) -> ObservableValue<(Observed, Observed1, Observed2)> {
        combine(with: relay1, relay2).compactMapped { combined in
            guard let first = combined.0, let second = combined.1, let third = combined.2 else { return nil }
            return (first, second, third)
        }
    }
    
    func compactCombine<Observed1, Observed2, Observed3>(
        with relay1: ObservableValue<Observed1>, _ relay2: ObservableValue<Observed2>, _ relay3: ObservableValue<Observed3>
    ) -> ObservableValue<(Observed, Observed1, Observed2, Observed3)> {
        combine(with: relay1, relay2, relay3).compactMapped { combined in
            guard let first = combined.0, let second = combined.1, let third = combined.2, let fourth = combined.3 else { return nil }
            return (first, second, third, fourth)
        }
    }
}

// MARK: ObservedObservable

public protocol ObservedObservable {
    func multipleSetDelayed(by delay: TimeInterval) -> Self
    func observe(on dispatcher: DispatchQueue) -> Self
    func alwaysAsync() -> Self
    @discardableResult
    func retain() -> Invokable
    @discardableResult
    func retained(by retainer: Retainer) -> Invokable
}

// MARK: Invokable

public protocol Invokable {
    func tryInvokeWithRecent()
}

// MARK: Relay

protocol AnyRelay: AnyObject {
    func tryRelay<Value>(changes: Changes<Value>)
    func isSameRelay(with anotherRelay: AnyRelay) -> Bool
}

protocol Relay: AnyRelay {
    associatedtype Relayed
    func relay(changes: Changes<Relayed>)
    func relay(changes: Changes<Relayed>, skip: AnyRelay)
}

extension Relay {
    func tryRelay<Value>(changes: Changes<Value>) {
        guard let mapped = changes.map({ $0 as? Relayed }) else { return }
        relay(changes: mapped)
    }
}
