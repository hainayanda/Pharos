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
    
    func bindable<State>(of keyPath: WritableKeyPath<Object, State>, key: UnsafeRawPointer) -> Observable<State> {
        guard let relay = objc_getAssociatedObject(underlyingObject, key) as? Observable<State> else {
            let newRelay = KVOObservable(underlyingObject, keyPath)
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
    
    func relayable<Observed>(of keyPath: WritableKeyPath<Object, Observed>) -> Observable<Observed> {
        let found = underlyingObject.findRetained {
            guard let kvo = $0 as? KVOObservable<Object, Observed> else { return false }
            return kvo.keyPath == keyPath
        }
        if let found = found as? KVOObservable<Object, Observed> { return found }
        let observable = KVOObservable(underlyingObject, keyPath)
        underlyingObject.retain(observable)
        return observable
    }
    
    public subscript<Property>(dynamicMember member: ReferenceWritableKeyPath<Object, Property>) -> Observable<Property> {
        relayable(of: member)
    }
}

var populatedRelayRetainingKey: String = "populatedRelayRetainingKey"

extension PopulatedRelays {
    
    func findRetained(where match: (AnyObject) -> Bool) -> AnyObject? {
        let retained = objc_getAssociatedObject(self, &populatedRelayRetainingKey) as? [AnyObject] ?? []
        return retained.first(where: match)
    }
    
    func retain(_ object: AnyObject) {
        var retained = objc_getAssociatedObject(self, &populatedRelayRetainingKey) as? [AnyObject] ?? []
        retained.append(self)
        objc_setAssociatedObject(self, &populatedRelayRetainingKey, retained, .OBJC_ASSOCIATION_RETAIN)
    }
}
