//
//  PublisherRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

final public class Publisher<Observed>: RootObservable<Observed> {
    
    public override init() { }
    
    public func publish(value: Observed) {
        relay(changes: Changes(old: recentState, new: value, source: self))
    }
}
