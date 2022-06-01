//
//  Retainer.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation
import Chary

final public class ContextRetainer {
    var retained: [ObjectIdentifier: AnyObject]
    
    public init(retained: [ObjectIdentifier: AnyObject]) {
        self.retained = retained
    }
    
    public init() {
        retained = [:]
    }
    
    public func add(retainer: ContextRetainer) {
        retainer.retained.forEach { (key, object) in
            retained[key] = object
        }
    }
    
    public func added(with object: AnyObject) -> ContextRetainer {
        let newSelf = ContextRetainer(retained: retained)
        newSelf.retained.append(object)
        return newSelf
    }
    
    public func discard(object: AnyObject) {
        retained.remove(object)
    }
}

final public class Retainer: ObjectRetainer {
    
    @Atomic var retained: [ObjectIdentifier: AnyObject] = [:]
    
    public init() { }
    
    public func retain(_ object: AnyObject) {
        retained.append(object)
    }
    
    public func discardAll() {
        retained = [:]
    }
    
    public func discard(_ object: AnyObject) {
        retained.remove(object)
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
    
    func relay(changes: Changes<Relayed>, context: PharosContext) {
        guard let wrapped = wrapped else {
            return
        }
        wrapped.tryRelay(changes: changes, context: context)
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
    
    @Atomic var relays: [ObjectIdentifier: AnyStateRelay] = [:]
    
    func relay(changes: Changes<Relayed>, context: PharosContext) {
        context.safeRun(for: self) {
            let copy = relays
            for relay in copy.values {
                relay.tryRelay(changes: changes, context: context)
            }
        }
    }
    
    func addToGroup(_ relay: AnyStateRelay) {
        guard let weakRelay = relay as? WeakRelayRetainer<Relayed>,
              let realRelay = weakRelay.wrapped else {
            relays.append(relay)
            return
        }
        relays[ObjectIdentifier(realRelay)] = weakRelay
    }
    
    func discard() {
        relays = [:]
    }
    
    @discardableResult
    func remove(_ relay: AnyStateRelay) -> Bool {
        guard let weakRelay = relay as? WeakRelayRetainer<Relayed>,
              let realRelay = weakRelay.wrapped else {
            guard relays.contains(relay) else { return false }
            relays.remove(relay)
            return true
        }
        guard relays.contains(realRelay) else { return false }
        relays.remove(realRelay)
        return true
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
        for (identifier, relay) in myRelays {
            guard let their = theirRelays[identifier],
                    their.isSameRelay(with: relay) else {
                return false
            }
        }
        return true
    }
}
