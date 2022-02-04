//
//  RelayInvoker.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

final class RelayInvoker<State>: Invokable {
    
    let relay: Observed<State>
    
    init(relay: Observed<State>) {
        self.relay = relay
    }
    
    func notifyWithCurrentValue() {
        guard let recent: State = self.relay.source?.recentState else {
            return
        }
        self.relay.relay(changes: Changes(old: nil, new: recent, source: self))
    }
}
