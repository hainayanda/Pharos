//
//  TwoWayRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 16/04/21.
//

import Foundation

open class TwoWayRelay<Value>: ValueRelay<Value>, CallBackRelay {
    public typealias ValueBack = Value
    
    public var callBackRelay: Consumer?
    
    public override init(currentValue: Value) {
        super.init(currentValue: currentValue)
    }
    
    @discardableResult
    open func relayBack(changes: Changes<Value>) -> Bool {
        guard let callBack = callBackRelay else {
            return relay(changes: changes)
        }
        callBack(changes)
        return true
    }
    
    open func relayBackConsumer(_ consumer: @escaping BackConsumer) {
        self.callBackRelay = consumer
    }
    
    open func apply(value: Value) {
        relay(
            changes: .init(
                old: currentValue,
                new: value,
                source: self
            )
        )
    }
}
