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
    open func whenDidSet(then consume: @escaping Consumer) -> Self {
        relayDispatch.consumer = consume
        return self
    }
    
    open override func discard() {
        super.discard()
    }
}
