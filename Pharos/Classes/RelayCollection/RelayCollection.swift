//
//  RelayCollection.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

public protocol PopulatedRelays: NSObject { }

extension NSObject: PopulatedRelays { }

public extension PopulatedRelays {
    var bearerRelays: BearerRelayCollection<Self> {
        .init(object: self)
    }
}

#if canImport(UIKit)
public extension PopulatedRelays where Self: UIView {
    var bondableRelays: RelayCollection<Self> {
        .init(object: self)
    }
}
#endif

public final class RelayCollection<Object: NSObject> {
    public let underlyingObject: Object
    
    init(object: Object) {
        self.underlyingObject = object
    }
}

@dynamicMemberLookup
public final class BearerRelayCollection<Object: NSObject> {
    public let underlyingObject: Object
    
    init(object: Object) {
        self.underlyingObject = object
    }
    
    public subscript<Property>(dynamicMember member: ReferenceWritableKeyPath<Object, Property>) -> AssociativeBearerRelay<Property> {
        .relay(of: underlyingObject, member)
    }
}
