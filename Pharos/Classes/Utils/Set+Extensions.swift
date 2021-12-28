//
//  Set+Extensions.swift
//  Pharos
//
//  Created by Nayanda Haberty on 27/12/21.
//

import Foundation

extension Set where Element: RelayHandler, Element: Discardable {
    mutating func relayAndRemoveInvalid(changes: Changes<Element.Value>) {
        var invalidRelays: [Element] = []
        forEach {
            guard $0.isValid else {
                invalidRelays.append($0)
                return
            }
            $0.relay(changes: changes)
        }
        invalidRelays.forEach { remove($0) }
    }
    
    mutating func cleanRelays() {
        forEach { $0.removeAllNextRelays() }
        removeAll()
    }
}
