//
//  Observable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

open class Observable<State>: ChangeObservable {
    lazy var temporaryRetainer: Retainer = Retainer()
    lazy var relayGroup: RelayRetainerGroup<State> = RelayRetainerGroup()
    var recentState: State? { nil }
    
    public init() { }
    
    open func whenDidSet(thenDo work: @escaping (Changes<State>) -> Void) -> Observed<State> {
        let observed = Observed(source: self, observer: work)
        temporaryRetainer.retain(observed)
        return observed
    }
    
    // MARK: Mappable
    
    open func compactMapped<Mapped>(_ mapper: @escaping (State) throws -> Mapped?) -> Observable<Mapped> {
        let observed = MappedObservable(source: self, mapper: mapper)
        temporaryRetainer.retain(observed)
        return observed
        
    }
    
    // MARK: Filterable
    
    open func ignore(when shouldIgnore: @escaping (Changes<State>) -> Bool) -> Observable<State> {
        let observed = FilteredObservable(source: self, filter: shouldIgnore)
        temporaryRetainer.retain(observed)
        return observed
    }
    
    // MARK: Combinable
    
    open func combine<State1>(with relay: Observable<State1>) -> Observable<(State?, State1?)> {
        let observed = BiCastObservable(source1: self, source2: relay)
        temporaryRetainer.retain(observed)
        relay.temporaryRetainer.retain(observed)
        return observed
    }
    
    open func combine<State1, State2>(
        with relay1: Observable<State1>, _ relay2: Observable<State2>
    ) -> Observable<(State?, State1?, State2?)> {
        let observed = TriCastObservable(source1: self, source2: relay1, source3: relay2)
        temporaryRetainer.retain(observed)
        relay1.temporaryRetainer.retain(observed)
        relay2.temporaryRetainer.retain(observed)
        return observed
    }
    
    open func combine<State1, State2, State3>(
        with relay1: Observable<State1>, _ relay2: Observable<State2>, _ relay3: Observable<State3>
    ) -> Observable<(State?, State1?, State2?, State3?)> {
        let observed = QuadCastObservable(source1: self, source2: relay1, source3: relay2, source4: relay3)
        temporaryRetainer.retain(observed)
        relay1.temporaryRetainer.retain(observed)
        relay2.temporaryRetainer.retain(observed)
        relay3.temporaryRetainer.retain(observed)
        return observed
    }
    
    // MARK: Mergable
    
    open func merge(with relays: Observable<State>...) -> Observable<State> {
        var merged = relays
        merged.insert(self, at: 0)
        let observed = MergedObservable(observables: merged)
        for relay in merged {
            relay.temporaryRetainer.retain(observed)
        }
        return observed
    }
    
    // MARK: Retain
    
    func retain<Child: StateRelay>(relay: Child) where Child.RelayedState == State {
        temporaryRetainer.discard(relay)
        relayGroup.addToGroup(relay)
    }
    
    func retainWeakly<Child: StateRelay>(relay: Child, managedBy retainer: ObjectRetainer) where Child.RelayedState == State {
        temporaryRetainer.discard(relay)
        relayGroup.addToGroup(WeakRelayRetainer<State>(wrapped: relay))
        retainer.retain(relay)
    }
}
