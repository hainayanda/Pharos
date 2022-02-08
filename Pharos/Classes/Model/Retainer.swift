//
//  Retainer.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

final public class Retainer: ObjectRetainer {
    
    @Atomic var retained: [AnyObject] = []
    
    public init() { }
    
    public func retain(_ object: AnyObject) {
        guard !retained.contains(where: { $0 === object }) else { return }
        retained.append(object)
    }
    
    public func discardAll() {
        retained = []
    }
    
    public func discard(_ object: AnyObject) {
        retained.removeAll { $0 === object }
    }
}

final class WeakObservableRetainer<Observed> {
    weak var wrapped: Observable<Observed>?
    
    init(wrapped: Observable<Observed>) {
        self.wrapped = wrapped
    }
}

final class WeakRelayRetainer<Relayed>: StateRelay {
    
    weak var wrapped: AnyStateRelay?
    
    init<Wrapped: StateRelay>(wrapped: Wrapped) {
        self.wrapped = wrapped
    }
    
    func relay(changes: Changes<Relayed>) {
        self.wrapped?.tryRelay(changes: changes)
    }
    
    func relay(changes: Changes<Relayed>, skip: AnyStateRelay) {
        guard let wrapped = self.wrapped, !wrapped.isSameRelay(with: skip) else {
            return
        }
        relay(changes: changes)
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        if anotherRelay === self {
            return true
        }
        guard let wrapped = wrapped else {
            return false
        }
        guard wrapped.isSameRelay(with: anotherRelay) else {
            if let weakRelay = anotherRelay as? WeakRelayRetainer<Relayed>,
                      let otherWrapped = weakRelay.wrapped {
                return wrapped.isSameRelay(with: otherWrapped)
            }
            return false
        }
        return true
    }
}

final class RelayRetainerGroup<Relayed>: StateRelay {
    
    @Atomic var relays: [AnyStateRelay] = []
    
    func relay(changes: Changes<Relayed>) {
        let copy = relays
        for relay in copy {
            relay.tryRelay(changes: changes)
        }
    }
    
    func relay(changes: Changes<Relayed>, skip: AnyStateRelay) {
        let copy = relays
        for relay in copy where !relay.isSameRelay(with: skip) {
            relay.tryRelay(changes: changes)
        }
    }
    
    func addToGroup(_ relay: AnyStateRelay) {
        remove(relay)
        relays.append(relay)
    }
    
    func discard() {
        relays = []
    }
    
    @discardableResult
    func remove(_ relay: AnyStateRelay) -> Bool {
        var found = false
        relays.removeAll {
            let sameRelay = $0.isSameRelay(with: relay)
            found = sameRelay || found
            return sameRelay
        }
        return found
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        guard let group = anotherRelay as? RelayRetainerGroup<Relayed> else {
            return false
        }
        if group === self { return true }
        let myRelays = relays
        let theirRelays = group.relays
        guard myRelays.count == theirRelays.count else {
            return false
        }
        for (index, relay) in myRelays.enumerated() {
            guard theirRelays[index].isSameRelay(with: relay) else {
                return false
            }
        }
        return true
    }
}
