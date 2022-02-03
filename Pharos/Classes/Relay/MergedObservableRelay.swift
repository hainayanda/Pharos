//
//  MergedObservableRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

final class MergedObservableRelay<Observed>: ObservableValue<Observed>, Relay {
    
    typealias Relayed = Observed
    
    let sources: [WeakObservableRetainer<Observed>]
    private var _recentValue: Observed?
    override var recentValue: Observed? {
        guard let recent = _recentValue else {
            return sources.reduce(nil) { partialResult, retainer in
                partialResult ?? retainer.wrapped?.recentValue
            }
        }
        return recent
    }
    
    init(observables: [ObservableValue<Observed>]) {
        sources = observables.map { WeakObservableRetainer(wrapped: $0) }
        super.init()
    }
    
    func relay(changes: Changes<Relayed>) {
        _recentValue = changes.new
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<Relayed>, skip: AnyRelay) {
        _recentValue = changes.new
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    override func retain<Child>(relay: Child) where Observed == Child.Relayed, Child : Relay {
        super.retain(relay: relay)
        for source in sources {
            source.wrapped?.retain(relay: self)
        }
    }
    
    override func retainWeakly<Child: Relay>(relay: Child, managedBy retainer: Retainer) where Observed == Child.Relayed {
        super.retainWeakly(relay: relay, managedBy: retainer)
        for source in sources {
            source.wrapped?.retainWeakly(relay: self, managedBy: retainer)
        }
    }
    
    func isSameRelay(with anotherRelay: AnyRelay) -> Bool {
        self === anotherRelay
    }
}
