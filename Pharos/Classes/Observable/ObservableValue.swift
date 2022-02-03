//
//  ObservableRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

open class ObservableValue<Observed>: ChangeObservable {
    lazy var temporaryRetainer: Retainer = Retainer()
    lazy var relayGroup: RelayRetainerGroup<Observed> = RelayRetainerGroup()
    var recentValue: Observed? { nil }
    
    open func whenDidSet(thenDo work: @escaping (Changes<Observed>) -> Void) -> ObservedRelay<Observed> {
        let observed = ObservedRelay(source: self, observer: work)
        temporaryRetainer.retain(observed)
        return observed
    }
    
    // MARK: Mappable
    
    open func compactMapped<Mapped>(_ mapper: @escaping (Observed) throws -> Mapped?) -> ObservableValue<Mapped> {
        let observed = MappedObservableRelay(source: self, mapper: mapper)
        temporaryRetainer.retain(observed)
        return observed
        
    }
    
    // MARK: Filterable
    
    open func ignore(when shouldIgnore: @escaping (Changes<Observed>) -> Bool) -> ObservableValue<Observed> {
        let observed = FilteredObservableRelay(source: self, filter: shouldIgnore)
        temporaryRetainer.retain(observed)
        return observed
    }
    
    // MARK: Combinable
    
    open func combine<Observed1>(with relay: ObservableValue<Observed1>) -> ObservableValue<(Observed?, Observed1?)> {
        let observed = BiCastObservableRelay(source1: self, source2: relay)
        temporaryRetainer.retain(observed)
        relay.temporaryRetainer.retain(observed)
        return observed
    }
    
    open func combine<Observed1, Observed2>(
        with relay1: ObservableValue<Observed1>, _ relay2: ObservableValue<Observed2>
    ) -> ObservableValue<(Observed?, Observed1?, Observed2?)> {
        let observed = TriCastObservableRelay(source1: self, source2: relay1, source3: relay2)
        temporaryRetainer.retain(observed)
        relay1.temporaryRetainer.retain(observed)
        relay2.temporaryRetainer.retain(observed)
        return observed
    }
    
    open func combine<Observed1, Observed2, Observed3>(
        with relay1: ObservableValue<Observed1>, _ relay2: ObservableValue<Observed2>, _ relay3: ObservableValue<Observed3>
    ) -> ObservableValue<(Observed?, Observed1?, Observed2?, Observed3?)> {
        let observed = QuadCastObservableRelay(source1: self, source2: relay1, source3: relay2, source4: relay3)
        temporaryRetainer.retain(observed)
        relay1.temporaryRetainer.retain(observed)
        relay2.temporaryRetainer.retain(observed)
        relay3.temporaryRetainer.retain(observed)
        return observed
    }
    
    // MARK: Mergable
    
    open func merge(with relays: ObservableValue<Observed>...) -> ObservableValue<Observed> {
        var merged = relays
        merged.insert(self, at: 0)
        let observed = MergedObservableRelay(observables: merged)
        for relay in merged {
            relay.temporaryRetainer.retain(observed)
        }
        return observed
    }
    
    // MARK: Retain
    
    func retain<Child: Relay>(relay: Child) where Child.Relayed == Observed {
        temporaryRetainer.discard(relay)
        relayGroup.addToGroup(relay)
    }
    
    func retainWeakly<Child: Relay>(relay: Child, managedBy retainer: Retainer) where Child.Relayed == Observed {
        temporaryRetainer.discard(relay)
        relayGroup.addToGroup(WeakRelayRetainer<Observed>(wrapped: relay))
        retainer.retain(relay)
    }
}
