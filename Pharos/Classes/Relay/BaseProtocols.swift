//
//  RelayProtocols.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

// MARK: ChangeObservable

public protocol ChangeObservable: MappableObservable, FilterableObservable, MergableObservable, CombinableObservable {
    associatedtype State
    
    func whenDidSet(thenDo work: @escaping (Changes<State>) -> Void) -> Observed<State>
    func relayChanges(to relay: BindableObservable<State>) -> Observed<State>
}

extension ChangeObservable {
    public func relayChanges(to relay: BindableObservable<State>) -> Observed<State> {
        whenDidSet { [weak relay] changes in
            guard let relay = relay else { return }
            if let selfRelay = self as? AnyStateRelay {
                relay.relay(changes: changes, skip: selfRelay)
            } else {
                relay.relay(changes: changes)
            }
        }
    }
}

// MARK: MappableObservable

public protocol MappableObservable {
    associatedtype State
    
    func mapped<Mapped>(_ mapper: @escaping (State) -> Mapped) -> Observable<Mapped>
    func compactMapped<Mapped>(_ mapper: @escaping (State) throws -> Mapped?) -> Observable<Mapped>
}

extension MappableObservable {
    public func mapped<Mapped>(_ mapper: @escaping (State) -> Mapped) -> Observable<Mapped> {
        compactMapped(mapper)
    }
}

// MARK: FilterableObservable

public protocol FilterableObservable {
    associatedtype State
    
    func ignore(when shouldIgnore: @escaping (Changes<State>) -> Bool) -> Observable<State>
    func onlyInclude(when shouldInclude: @escaping (Changes<State>) -> Bool) -> Observable<State>
}

extension FilterableObservable {
    public func onlyInclude(when shouldInclude: @escaping (Changes<State>) -> Bool) -> Observable<State> {
        ignore { changes in
            !shouldInclude(changes)
        }
    }
}

extension FilterableObservable where Self: AnyObject {
    public func onlyFromBinding() -> Observable<State> {
        ignore { [weak self] changes in
            guard let self = self else { return true }
            if let child = self as? ChildObservable {
                return changes.source === child.parent
            } else {
                return changes.source === self
            }
        }
    }
    
    public func onlyFromSet() -> Observable<State> {
        ignore { [weak self] changes in
            guard let self = self else { return true }
            if let child = self as? ChildObservable {
                return !(changes.source === child.parent)
            } else {
                return !(changes.source === self)
            }
        }
    }
    
    public func whenBindingDidChange(thenDo work: @escaping (Changes<State>) -> Void) -> Observed<State> {
        onlyFromBinding().whenDidSet(thenDo: work)
    }
    
    public func whenPropertyDidSet(thenDo work: @escaping (Changes<State>) -> Void) -> Observed<State> {
        onlyFromBinding().whenDidSet(thenDo: work)
    }
}

public extension FilterableObservable where State: Equatable {
    func ignoreSameValue() -> Observable<State> {
        ignore { $0.isNotChanging }
    }
}

// MARK: MergableObservable

public protocol MergableObservable {
    associatedtype State
    
    func merge(with relays: Observable<State>...) -> Observable<State>
}

// MARK: CombinableObservable

public protocol CombinableObservable {
    associatedtype State
    
    func combine<Observed1>(with relay: Observable<Observed1>) -> Observable<(State?, Observed1?)>
    func combine<Observed1, Observed2>(
        with relay1: Observable<Observed1>, _ relay2: Observable<Observed2>
    ) -> Observable<(State?, Observed1?, Observed2?)>
    func combine<Observed1, Observed2, Observed3>(
        with relay1: Observable<Observed1>, _ relay2: Observable<Observed2>, _ relay3: Observable<Observed3>
    ) -> Observable<(State?, Observed1?, Observed2?, Observed3?)>
}

public extension CombinableObservable {
    func compactCombine<Observed1>(with relay: Observable<Observed1>) -> Observable<(State, Observed1)> {
        combine(with: relay).compactMapped { combined in
            guard let first = combined.0, let second = combined.1 else { return nil }
            return (first, second)
        }
    }
    
    func compactCombine<Observed1, Observed2>(
        with relay1: Observable<Observed1>, _ relay2: Observable<Observed2>
    ) -> Observable<(State, Observed1, Observed2)> {
        combine(with: relay1, relay2).compactMapped { combined in
            guard let first = combined.0, let second = combined.1, let third = combined.2 else { return nil }
            return (first, second, third)
        }
    }
    
    func compactCombine<Observed1, Observed2, Observed3>(
        with relay1: Observable<Observed1>, _ relay2: Observable<Observed2>, _ relay3: Observable<Observed3>
    ) -> Observable<(State, Observed1, Observed2, Observed3)> {
        combine(with: relay1, relay2, relay3).compactMapped { combined in
            guard let first = combined.0, let second = combined.1, let third = combined.2, let fourth = combined.3 else { return nil }
            return (first, second, third, fourth)
        }
    }
}

// MARK: ObservedSubject

public protocol ObservedSubject {
    associatedtype State
    
    func multipleSetDelayed(by delay: TimeInterval) -> Self
    func observe(on dispatcher: DispatchQueue) -> Self
    func asynchronously() -> Self
    @discardableResult
    func retain() -> Invokable
    @discardableResult
    func retained(by retainer: ObjectRetainer) -> Invokable
    @discardableResult
    func retainUntil(lastStateMatch: @escaping (Changes<State>) -> Bool) -> Invokable
    @discardableResult
    func retain(for timeInterval: TimeInterval) -> Invokable
}

extension ObservedSubject {
    
    @discardableResult
    func retainUntil(nextEventCount maxCount: Int) -> Invokable {
        var currentCount: Int = 0
        return retainUntil { _ in
            currentCount += 1
            return currentCount >= maxCount
        }
    }
    
    @discardableResult
    func retainUntilNextState() -> Invokable {
        retainUntil(nextEventCount: 1)
    }
}

// MARK: Invokable

public protocol Invokable {
    func notifyWithCurrentValue()
}

// MARK: Relay

protocol AnyStateRelay: AnyObject {
    func tryRelay<Value>(changes: Changes<Value>)
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool
}

protocol StateRelay: AnyStateRelay {
    associatedtype RelayedState
    func relay(changes: Changes<RelayedState>)
    func relay(changes: Changes<RelayedState>, skip: AnyStateRelay)
}

extension StateRelay {
    func tryRelay<Value>(changes: Changes<Value>) {
        guard let mapped = changes.map({ $0 as? RelayedState }) else { return }
        relay(changes: mapped)
    }
}

// MARK: ChildObservable

protocol ChildObservable {
    var parent: AnyObject? { get }
}
