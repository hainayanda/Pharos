//
//  MergedObservable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

final class MergedObservable<Observed>: Observable<Observed>, StateRelay {
    
    typealias RelayedState = Observed
    
    let sources: [WeakObservableRetainer<Observed>]
    private var _recentValue: Observed?
    override var recentState: Observed? {
        guard let recent = _recentValue else {
            return sources.reduce(nil) { partialResult, retainer in
                partialResult ?? retainer.wrapped?.recentState
            }
        }
        return recent
    }
    
    init(observables: [Observable<Observed>]) {
        sources = observables.map { WeakObservableRetainer(wrapped: $0) }
        super.init()
    }
    
    func relay(changes: Changes<RelayedState>) {
        let oldValue = _recentValue ?? changes.old
        _recentValue = changes.new
        relayGroup.relay(changes: Changes(old: oldValue, new: changes.new, source: changes.source))
    }
    
    func relay(changes: Changes<RelayedState>, skip: AnyStateRelay) {
        _recentValue = changes.new
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    override func retain<Child>(relay: Child) where Observed == Child.RelayedState, Child : StateRelay {
        super.retain(relay: relay)
        for source in sources {
            source.wrapped?.retain(relay: self)
        }
    }
    
    override func retainWeakly<Child: StateRelay>(relay: Child, managedBy retainer: ObjectRetainer) where Observed == Child.RelayedState {
        super.retainWeakly(relay: relay, managedBy: retainer)
        for source in sources {
            source.wrapped?.retainWeakly(relay: self, managedBy: retainer)
        }
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}
