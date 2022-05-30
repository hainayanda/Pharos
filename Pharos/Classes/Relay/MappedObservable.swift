//
//  MappedObservable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

final class MappedObservable<Original, Mapped>: Observable<Mapped>, StateRelay, ChildObservable {
    
    typealias RelayedState = Original
    typealias Mapper = (Original) throws -> Mapped?
    
    weak var source: Observable<RelayedState>?
    var parent: AnyObject? { (source as? ChildObservable)?.parent ?? source }
    
    override var recentState: State? {
        guard let recentValue = source?.recentState else {
            return nil
        }
        return try? mapper(recentValue)
    }
    
    let mapper: Mapper
    
    init(source: Observable<RelayedState>, mapper: @escaping Mapper) {
        self.source = source
        self.mapper = mapper
    }
    
    func relay(changes: Changes<Original>) {
        guard let mappedChanges = changes.map(mapper) else {
            return
        }
        relayGroup.relay(changes: mappedChanges)
    }
    
    func relay(changes: Changes<Original>, skip: AnyStateRelay) {
        guard let mappedChanges = changes.map(mapper) else {
            return
        }
        relayGroup.relay(changes: mappedChanges, skip: skip)
    }
    
    override func retain<Child>(relay: Child) where Mapped == Child.RelayedState, Child : StateRelay {
        super.retain(relay: relay)
        source?.retain(relay: self)
    }
    
    override func retainWeakly<Child: StateRelay>(relay: Child, managedBy retainer: ObjectRetainer) where Mapped == Child.RelayedState {
        super.retainWeakly(relay: relay, managedBy: retainer)
        source?.retainWeakly(relay: self, managedBy: retainer)
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}
