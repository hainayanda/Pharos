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
    
    init(observables: [Observable<Observed>], retainer: ContextRetainer) {
        sources = observables.map { WeakObservableRetainer(wrapped: $0) }
        super.init(retainer: retainer)
        observables.forEach {
            $0.relayGroup.addToGroup(WeakRelayRetainer<Observed>(wrapped: self))
        }
    }
    
    func relay(changes: Changes<RelayedState>, context: PharosContext) {
        context.safeRun(for: self) {
            let oldValue = _recentValue ?? changes.old
            _recentValue = changes.new
            relayGroup.relay(
                changes: Changes(old: oldValue, new: changes.new, source: changes.source),
                context: context
            )
        }
    }
    
    override func retain(retainer: ContextRetainer) {
        for source in sources {
            source.wrapped?.retain(retainer: retainer)
        }
    }
    
    override func discard(child: AnyObject) {
        contextRetainer.discard(object: child)
        for source in sources {
            source.wrapped?.discard(child: child)
        }
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}
