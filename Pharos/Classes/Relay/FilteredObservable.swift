//
//  IgnoringObservableRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

final class FilteredObservable<Observed>: Observable<Observed>, StateRelay, ChildObservable {
    
    typealias RelayedState = Observed
    typealias Filter = (Changes<Observed>) -> Bool
    
    weak var source: Observable<RelayedState>?
    var parent: AnyObject? { (source as? ChildObservable)?.parent ?? source }
    
    override var recentState: Observed? {
        guard let recent = source?.recentState,
                !filter(Changes(old: nil, new: recent, source: self)) else {
            return nil
        }
        return recent
    }
    
    let filter: Filter
    
    init(source: Observable<Observed>, filter: @escaping Filter) {
        self.source = source
        self.filter = filter
    }
    
    func relay(changes: Changes<RelayedState>) {
        guard !filter(changes) else {
            return
        }
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<Observed>, skip: AnyStateRelay) {
        guard !filter(changes) else {
            return
        }
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    override func retain<Child>(relay: Child) where Observed == Child.RelayedState, Child : StateRelay {
        super.retain(relay: relay)
        source?.retain(relay: self)
    }
    
    override func retainWeakly<Child: StateRelay>(relay: Child, managedBy retainer: ObjectRetainer) where Observed == Child.RelayedState {
        super.retainWeakly(relay: relay, managedBy: retainer)
        source?.retainWeakly(relay: self, managedBy: retainer)
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}
