//
//  Observable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

@propertyWrapper
public class Observable<Wrapped>: StateObservable {
    lazy public internal(set) var relay: BondableRelay<Wrapped> = {
        let relay = BondableRelay<Wrapped>(currentValue: _wrappedValue)
        relay.relayBackConsumer { [weak self] changes in
            guard let self = self else { return }
            self.setAndInformToRelay(with: changes)
        }
        return relay
    }()
    private var _wrappedValue: Wrapped
    public var wrappedValue: Wrapped {
        get {
            _wrappedValue
        }
        set {
            setAndInformToRelay(with: Changes(old: _wrappedValue, new: newValue, source: self))
        }
    }
    
    public init(wrappedValue: Wrapped) {
        self._wrappedValue = wrappedValue
    }
    
    public var projectedValue: BondableRelay<Wrapped> {
        relay
    }
    
    public func invokeRelayWithCurrent() {
        informDidSetToRelay(with: .init(old: _wrappedValue, new: _wrappedValue, source: self))
    }
    
    public func removeBond() {
        relay.bondingRelay = nil
    }
    
    public func removeAllRelay() {
        relay.removeAllNextRelays()
    }
    
    func setAndInformToRelay(with changes: Changes<Wrapped>) {
        _wrappedValue = changes.new
        informDidSetToRelay(with: changes)
    }
    
    func informDidSetToRelay(with changes: Changes<Wrapped>) {
        relay.relay(changes: changes)
    }
}
