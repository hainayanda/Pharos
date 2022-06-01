//
//  PharosContext.swift
//  Pharos
//
//  Created by Nayanda Haberty on 31/05/22.
//

import Foundation
import Chary

public final class PharosContext {
    @Atomic var notifiedRelay: [ObjectIdentifier: AnyStateRelay] = [:]
    
    func alreadyNotified(for relay: AnyStateRelay) -> Bool {
        notifiedRelay.contains(relay)
    }
    
    func safeRun(for relay: AnyStateRelay, runner: () -> Void) {
        guard !alreadyNotified(for: relay) else { return }
        notifiedRelay.append(relay)
        runner()
    }
}
