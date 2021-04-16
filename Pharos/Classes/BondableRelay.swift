//
//  BondableRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public class BondableRelay<Value>: TwoWayRelay<Value> {
    var bondingRelay: BaseRelay<Value>?
    var outsideInvoked: Bool = false
    
    public override func relay(changes: Changes<Value>) {
        super.relay(changes: changes)
        bondingRelay?.relay(changes: changes)
    }
    
    @discardableResult
    public func bonding(with twoWayRelay: TwoWayRelay<Value>) -> Self {
        relayNotification(to: twoWayRelay)
        twoWayRelay.relayBackConsumer { [weak self] changes in
            self?.relayBack(changes: changes)
        }
        return self
    }
    
    @discardableResult
    public func bondAndApply(to twoWayRelay: TwoWayRelay<Value>) -> Self {
        twoWayRelay.apply(value: currentValue)
        return bonding(with: twoWayRelay)
    }
    
    @discardableResult
    public func bondAndMap(from twoWayRelay: TwoWayRelay<Value>) -> Self {
        relayBack(
            changes: .init(
                old: currentValue,
                new: twoWayRelay.currentValue,
                source: self
            )
        )
        return bonding(with: twoWayRelay)
    }
    
    public override func removeAllNextRelays() {
        super.removeAllNextRelays()
        bondingRelay = nil
    }
}
