//
//  ValueRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

open class ValueRelay<Value>: BearerRelay<Value>, ObservableRelay {
    
    public init(currentValue: Value) {
        super.init(currentValue: currentValue, consumer: nil)
    }
    
    @discardableResult
    public func whenDidSet(then consume: @escaping Consumer) -> Self {
        relayDispatch.consumer = consume
        return self
    }
    
    public override func discard() {
        relayDispatch.consumer = nil
    }
}
