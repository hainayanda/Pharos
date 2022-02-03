//
//  MappedObservableRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

final class MappedObservableRelay<Original, Mapped>: ObservableValue<Mapped>, Relay {
    
    typealias Relayed = Original
    typealias Mapper = (Original) throws -> Mapped?
    
    weak var source: ObservableValue<Relayed>?
    
    override var recentValue: Observed? {
        guard let recentValue = source?.recentValue else {
            return nil
        }
        return try? mapper(recentValue)
    }
    
    let mapper: Mapper
    
    init(source: ObservableValue<Relayed>, mapper: @escaping Mapper) {
        self.source = source
        self.mapper = mapper
    }
    
    func relay(changes: Changes<Original>) {
        guard let mappedChanges = changes.map(mapper) else {
            return
        }
        relayGroup.relay(changes: mappedChanges)
    }
    
    func relay(changes: Changes<Original>, skip: AnyRelay) {
        guard let mappedChanges = changes.map(mapper) else {
            return
        }
        relayGroup.relay(changes: mappedChanges, skip: skip)
    }
    
    override func retain<Child>(relay: Child) where Mapped == Child.Relayed, Child : Relay {
        super.retain(relay: relay)
        source?.retain(relay: self)
    }
    
    override func retainWeakly<Child: Relay>(relay: Child, managedBy retainer: Retainer) where Mapped == Child.Relayed {
        super.retainWeakly(relay: relay, managedBy: retainer)
        source?.retainWeakly(relay: self, managedBy: retainer)
    }
    
    func isSameRelay(with anotherRelay: AnyRelay) -> Bool {
        self === anotherRelay
    }
}
