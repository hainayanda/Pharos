//
//  ObservableRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

open class RootObservableRelay<Observed>: ObservableValue<Observed>, Relay {
    
    typealias Relayed = Observed
    private var _recentValue: Observed?
    override var recentValue: Observed? { _recentValue }
    
    func relay(changes: Changes<Relayed>) {
        _recentValue = changes.new
        relayGroup.relay(changes: changes)
    }
    
    func relay(changes: Changes<Relayed>, skip: AnyRelay) {
        _recentValue = changes.new
        relayGroup.relay(changes: changes, skip: skip)
    }
    
    func isSameRelay(with anotherRelay: AnyRelay) -> Bool {
        self === anotherRelay
    }
}
