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
    
    public override init() {
        super.init()
    }
    
    func relay(changes: Changes<RelayedState>) {
        _recentValue = changes.new
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<RelayedState>, skip: AnyStateRelay) {
        _recentValue = changes.new
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}
