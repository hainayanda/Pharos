//
//  AssociativeRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 19/06/21.
//

import Foundation

open class AssociativeValueRelay<Value>: ValueRelay<Value>, AssociativeRelay {
    
    weak var associatedObject: AnyObject?
    
    public init(_ object: AnyObject, currentValue: Value) {
        self.associatedObject = object
        super.init(currentValue: currentValue)
    }
    
    public func retainWithSource() -> Self {
        guard let object = associatedObject else { return self }
        objc_setAssociatedObject(
            object,
            String(ObjectIdentifier(self).hashValue)
                + String(ObjectIdentifier(object).hashValue),
            self,
            .OBJC_ASSOCIATION_RETAIN
        )
        return self
    }
}

open class AssociativeTwoWayRelay<Value>: TwoWayRelay<Value>, AssociativeRelay {
    
    weak var associatedObject: AnyObject?
    
    public init(_ object: AnyObject, currentValue: Value) {
        self.associatedObject = object
        super.init(currentValue: currentValue)
    }
    
    public func retainWithSource() -> Self {
        guard let object = associatedObject else { return self }
        objc_setAssociatedObject(
            object,
            String(ObjectIdentifier(self).hashValue)
                + String(ObjectIdentifier(object).hashValue),
            self,
            .OBJC_ASSOCIATION_RETAIN
        )
        return self
    }
}
