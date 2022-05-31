//
//  ObservableRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

open class RootObservable<Observed>: Observable<Observed>, StateRelay {
    typealias RelayedState = Observed
    
    private var _recentValue: Observed?
    override var recentState: Observed? { _recentValue }
    
    public override init(retainer: ContextRetainer) {
        super.init(retainer: retainer)
    }
    
    func relay(changes: Changes<RelayedState>, context: PharosContext) {
        context.safeRun(for: self) {
            _recentValue = changes.new
            relayGroup.relay(changes: changes, context: context)
        }
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
    
    public override func relayChanges(to relay: BindableObservable<State>) -> Pharos.Observed<Observed> {
        let observed = Pharos.Observed(source: self, retainer: self.contextRetainer.added(with: self)) { [weak relay] changes, context in
            guard let relay = relay else { return }
            relay.relay(changes: changes, context: context)
        }
        relayGroup.addToGroup(WeakRelayRetainer<Observed>(wrapped: observed))
        return observed
    }
}
