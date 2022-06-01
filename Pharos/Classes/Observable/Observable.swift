//
//  Observable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

open class Observable<State>: ChangeObservable {
    let contextRetainer: ContextRetainer
    lazy var relayGroup: RelayRetainerGroup<State> = RelayRetainerGroup()
    var recentState: State? { nil }
    
    public init(retainer: ContextRetainer) {
        self.contextRetainer = retainer
    }
    
    open func whenDidSet(thenDo work: @escaping (Changes<State>) -> Void) -> Observed<State> {
        let observed = Observed(source: self, retainer: contextRetainer.added(with: self)) { changes, _ in
            work(changes)
        }
        relayGroup.addToGroup(WeakRelayRetainer<State>(wrapped: observed))
        return observed
    }
    
    public func relayChanges(to relay: BindableObservable<State>) -> Observed<State> {
        let observed = Observed(source: self, retainer: contextRetainer.added(with: self)) { [weak relay] changes, context in
            guard let relay = relay else { return }
            relay.relay(changes: changes, context: context)
        }
        relayGroup.addToGroup(WeakRelayRetainer<State>(wrapped: observed))
        return observed
    }
    
    // MARK: Mappable
    
    open func compactMapped<Mapped>(_ mapper: @escaping (State) throws -> Mapped?) -> Observable<Mapped> {
        let observed = MappedObservable(source: self, retainer: contextRetainer.added(with: self), mapper: mapper)
        relayGroup.addToGroup(WeakRelayRetainer<State>(wrapped: observed))
        return observed
        
    }
    
    // MARK: Filterable
    
    open func ignore(when shouldIgnore: @escaping (Changes<State>) -> Bool) -> Observable<State> {
        let observed = FilteredObservable(source: self, retainer: contextRetainer.added(with: self), filter: shouldIgnore)
        relayGroup.addToGroup(WeakRelayRetainer<State>(wrapped: observed))
        return observed
    }
    
    // MARK: Combinable
    
    open func combine<State1>(with relay: Observable<State1>) -> Observable<(State?, State1?)> {
        BiCastObservable(source1: self, source2: relay, retainer: contextRetainer)
    }
    
    open func combine<State1, State2>(
        with relay1: Observable<State1>, _ relay2: Observable<State2>
    ) -> Observable<(State?, State1?, State2?)> {
        TriCastObservable(source1: self, source2: relay1, source3: relay2, retainer: contextRetainer)
    }
    
    open func combine<State1, State2, State3>(
        with relay1: Observable<State1>, _ relay2: Observable<State2>, _ relay3: Observable<State3>
    ) -> Observable<(State?, State1?, State2?, State3?)> {
        QuadCastObservable(source1: self, source2: relay1, source3: relay2, source4: relay3, retainer: contextRetainer)
    }
    
    // MARK: Mergable
    
    open func merge(with relays: Observable<State>...) -> Observable<State> {
        var merged = relays
        merged.insert(self, at: 0)
        var retainer = contextRetainer
        for relay in merged {
            retainer = retainer.added(with: relay)
        }
        return MergedObservable(observables: merged, retainer: retainer)
    }
    
    // MARK: Retain
    
    func retain(retainer: ContextRetainer) {
        retainer.retained.remove(self)
        self.contextRetainer.add(retainer: retainer)
    }
    
    func discard(child: AnyObject) {
        contextRetainer.discard(object: child)
    }
}
