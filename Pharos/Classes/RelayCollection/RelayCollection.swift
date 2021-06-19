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

public class RelayCollection<Object: NSObject> {
    let object: Object
    
    init(object: Object) {
        self.object = object
    }
}

@dynamicMemberLookup
public class BearerRelayCollection<Object: NSObject> {
    let object: Object
    
    init(object: Object) {
        self.object = object
    }
    
    public subscript<Property>(dynamicMember member: ReferenceWritableKeyPath<Object, Property>) -> AssociativeBearerRelay<Property> {
        .relay(of: object, member)
    }
}
