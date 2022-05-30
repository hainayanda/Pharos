//
//  PharosContext.swift
//  Pharos
//
//  Created by Nayanda Haberty on 31/05/22.
//

import Foundation

class PharosContext {
    @Atomic var notifiedRelay: [AnyStateRelay] = []
    
    func alreadyNotified(for relay: AnyStateRelay) -> Bool {
        notifiedRelay.contains { $0 === relay }
    }
    
    func safeRun(for relay: AnyStateRelay, runner: () -> Void) {
        guard !alreadyNotified(for: relay) else { return }
        notifiedRelay.append(relay)
        runner()
    }
}
