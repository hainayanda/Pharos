//
//  IgnoringObservableRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

final class FilteredObservableRelay<Observed>: ObservableValue<Observed>, Relay {
    
    typealias Relayed = Observed
    typealias Filter = (Changes<Observed>) -> Bool
    
    weak var source: ObservableValue<Relayed>?
    
    override var recentValue: Observed? {
        guard let recent = source?.recentValue,
                !filter(Changes(old: nil, new: recent, source: self)) else {
            return nil
        }
        return recent
    }
    
    let filter: Filter
    
    init(source: ObservableValue<Observed>, filter: @escaping Filter) {
        self.source = source
        self.filter = filter
    }
    
    func relay(changes: Changes<Relayed>) {
        guard !filter(changes) else {
            return
        }
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<Observed>, skip: AnyRelay) {
        guard !filter(changes) else {
            return
        }
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    override func retain<Child>(relay: Child) where Observed == Child.Relayed, Child : Relay {
        super.retain(relay: relay)
        source?.retain(relay: self)
    }
    
    override func retainWeakly<Child: Relay>(relay: Child, managedBy retainer: Retainer) where Observed == Child.Relayed {
        super.retainWeakly(relay: relay, managedBy: retainer)
        source?.retainWeakly(relay: self, managedBy: retainer)
    }
    
    func isSameRelay(with anotherRelay: AnyRelay) -> Bool {
        self === anotherRelay
    }
}
