//
//  PopulatedRelays.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension PopulatedRelays where Self: UIView {
    var bindables: BindableCollection<Self> {
        .init(object: self)
    }
}

public final class BindableCollection<Object: NSObject> {
    let underlyingObject: Object

    init(object: Object) {
        self.underlyingObject = object
    }
    
    func bindable<State>(of keyPath: ReferenceWritableKeyPath<Object, State>) -> BindableObservable<State> {
        let key = String(ObjectIdentifier(keyPath).hashValue)
        guard let relay = objc_getAssociatedObject(underlyingObject, key) as? BindableObservable<State> else {
            let newRelay = BindableKVOObservable(object: underlyingObject, keyPath: keyPath)
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
    var relayables: RelayableCollection<Self> {
        .init(object: self)
    }
}

@dynamicMemberLookup
public final class RelayableCollection<Object: NSObject> {
    let underlyingObject: Object
    
    init(object: Object) {
        self.underlyingObject = object
    }
    
    func relayable<Observed>(of keyPath: ReferenceWritableKeyPath<Object, Observed>) -> BindableObservable<Observed> {
        let key = String(keyPath.hashValue)
        guard let relay = objc_getAssociatedObject(underlyingObject, key) as? BindableObservable<Observed> else {
            let newRelay = BindableKVOObservable(object: underlyingObject, keyPath: keyPath)
            objc_setAssociatedObject(underlyingObject, key, newRelay, .OBJC_ASSOCIATION_RETAIN)
            return newRelay
        }
        return relay
    }
    
    public subscript<Property>(dynamicMember member: ReferenceWritableKeyPath<Object, Property>) -> BindableObservable<Property> {
        relayable(of: member)
    }
}
