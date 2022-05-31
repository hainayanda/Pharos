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
    
    init(source: Observable<Observed>, retainer: ContextRetainer, filter: @escaping Filter) {
        self.source = source
        self.filter = filter
        super.init(retainer: retainer)
    }
    
    func relay(changes: Changes<RelayedState>, context: PharosContext) {
        context.safeRun(for: self) {
            guard !filter(changes) else {
                return
            }
            relayGroup.relay(changes: changes, context: context)
        }
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
