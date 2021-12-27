//
//  Set+Extensions.swift
//  Pharos
//
//  Created by Nayanda Haberty on 27/12/21.
//

import Foundation

extension Set where Element: RelayHandler {
    func relay(changes: Changes<Element.Value>) {
        forEach { $0.relay(changes: changes) }
    }
    
    mutating func cleanRelays() {
        forEach { $0.removeAllNextRelays() }
        removeAll()
    }
}
