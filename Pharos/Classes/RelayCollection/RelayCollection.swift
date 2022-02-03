//
//  RelayCollection.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension PopulatedRelays where Self: UIView {
    var bindables: RelayCollection<Self> {
        .init(object: self)
    }
}

public final class RelayCollection<Object: NSObject> {
    public let underlyingObject: Object

    init(object: Object) {
        self.underlyingObject = object
    }
    
    func bindable<Observed>(of keyPath: ReferenceWritableKeyPath<Object, Observed>) -> BindableRelay<Observed> {
        let key = String(keyPath.hashValue)
        guard let relay = objc_getAssociatedObject(underlyingObject, key) as? BindableRelay<Observed> else {
            let newRelay = KVORelay(object: underlyingObject, keyPath: keyPath)
            objc_setAssociatedObject(underlyingObject, key, newRelay, .OBJC_ASSOCIATION_RETAIN)
            return newRelay
        }
        return relay
    }
}
#endif

public protocol PopulatedRelays: NSObject { }

extension NSObject: PopulatedRelays { }

public extension PopulatedRelays {
    var relayables: AutoRelayCollection<Self> {
        .init(object: self)
    }
}

@dynamicMemberLookup
public final class AutoRelayCollection<Object: NSObject> {
    public let underlyingObject: Object
    
    init(object: Object) {
        self.underlyingObject = object
    }
    
    func relayable<Observed>(of keyPath: ReferenceWritableKeyPath<Object, Observed>) -> BindableRelay<Observed> {
        let key = String(keyPath.hashValue)
        guard let relay = objc_getAssociatedObject(underlyingObject, key) as? BindableRelay<Observed> else {
            let newRelay = KVORelay(object: underlyingObject, keyPath: keyPath)
            objc_setAssociatedObject(underlyingObject, key, newRelay, .OBJC_ASSOCIATION_RETAIN)
            return newRelay
        }
        return relay
    }
    
    public subscript<Property>(dynamicMember member: ReferenceWritableKeyPath<Object, Property>) -> BindableRelay<Property> {
        relayable(of: member)
    }
}
