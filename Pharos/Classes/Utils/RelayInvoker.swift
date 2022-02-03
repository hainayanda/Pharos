//
//  RelayInvoker.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

class RelayInvoker<Observed>: Invokable {
    
    let relay: ObservedRelay<Observed>
    
    init(relay: ObservedRelay<Observed>) {
        self.relay = relay
    }
    
    func tryInvokeWithRecent() {
        guard let recent: Observed = self.relay.source?.recentValue else {
            return
        }
        self.relay.relay(changes: Changes(old: nil, new: recent, source: self))
    }
}
