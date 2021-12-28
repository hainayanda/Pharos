//
//  BondableRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public final class BondableRelay<Value>: TwoWayRelay<Value> {
    var bondingRelay: BaseRelay<Value>?
    var outsideInvoked: Bool = false
    
    @discardableResult
    public override func relay(changes: Changes<Value>) -> Bool {
        guard super.relay(changes: changes) else { return false }
        bondingRelay?.relay(changes: changes)
        return true
    }
    
    @discardableResult
    public func bonding(with twoWayRelay: TwoWayRelay<Value>) -> Self {
        add(observer: twoWayRelay)
        twoWayRelay.relayBackConsumer { [weak self] changes in
            self?.relayBack(changes: changes)
        }
        return self
    }
    
    @discardableResult
    public func bondAndApply(to twoWayRelay: TwoWayRelay<Value>) -> Self {
        if let value = currentValue.value {
            twoWayRelay.apply(value: value)
        }
        return bonding(with: twoWayRelay)
    }
    
    @discardableResult
    public func bondAndMap(from twoWayRelay: TwoWayRelay<Value>) -> Self {
        if let value = twoWayRelay.currentValue.value {
            relayBack(
                changes: .init(
                    old: currentValue,
                    new: value,
                    source: self
                )
            )
        }
        return bonding(with: twoWayRelay)
    }
    
    public override func removeAllNextRelays() {
        super.removeAllNextRelays()
        bondingRelay = nil
    }
}
