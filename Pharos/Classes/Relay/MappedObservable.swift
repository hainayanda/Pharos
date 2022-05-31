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
    
    init(source: Observable<RelayedState>, retainer: ContextRetainer, mapper: @escaping Mapper) {
        self.source = source
        self.mapper = mapper
        super.init(retainer: retainer)
    }
    
    func relay(changes: Changes<Original>, context: PharosContext) {
        guard let mappedChanges = changes.map(mapper) else {
            return
        }
        relayGroup.relay(changes: mappedChanges, context: context)
    }
    
    override func retain(retainer: ContextRetainer) {
        source?.retain(retainer: retainer)
    }
    
    override func discard(child: AnyObject) {
        contextRetainer.discard(object: child)
        source?.discard(child: child)
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}
