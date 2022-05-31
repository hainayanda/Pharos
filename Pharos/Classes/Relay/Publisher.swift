//
//  PublisherRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

open class Publisher<Observed>: RootObservable<Observed> {
    
    public init() {
        super.init(retainer: ContextRetainer())
    }
    
    open func publish(value: Observed) {
        relay(
            changes: Changes(old: recentState, new: value, source: self),
            context: PharosContext()
        )
    }
}
