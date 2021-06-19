//
//  AssociativeRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 19/06/21.
//

import Foundation

open class AssociativeBearerRelay<Value>: BearerRelay<Value>, AssociativeRelay {
    
    public weak var associatedObject: AnyObject?
    
    public init(_ object: AnyObject, currentValue: Value, consumer: ((Changes<Value>) -> Void)?) {
        self.associatedObject = object
        super.init(currentValue: currentValue, consumer: consumer)
    }
}

open class AssociativeValueRelay<Value>: ValueRelay<Value>, AssociativeRelay {
    
    public weak var associatedObject: AnyObject?
    
    public init(_ object: AnyObject, currentValue: Value) {
        self.associatedObject = object
        super.init(currentValue: currentValue)
    }
}

open class AssociativeTwoWayRelay<Value>: TwoWayRelay<Value>, AssociativeRelay {
    
    public weak var associatedObject: AnyObject?
    
    public init(_ object: AnyObject, currentValue: Value) {
        self.associatedObject = object
        super.init(currentValue: currentValue)
    }
}
