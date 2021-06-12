//
//  RelayCollection.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation

public protocol PopulatedRelays: NSObject {
    associatedtype BaseRelayObject: NSObject
    var relays: RelayCollection<BaseRelayObject> { get }
}

public extension PopulatedRelays where BaseRelayObject == Self {
    var relays: RelayCollection<BaseRelayObject> {
        .init(object: self)
    }
}

public class RelayCollection<Object: NSObject> {
    let object: Object
    
    init(object: Object) {
        self.object = object
    }
    
    public func create<Property>(forRefKeyPath keyPath: ReferenceWritableKeyPath<Object, Property>) -> TwoWayRelay<Property> {
        .relay(of: object, keyPath)
    }
    
    public func create<Property>(forKeyPath keyPath: KeyPath<Object, Property>) -> ValueRelay<Property> {
        .relay(of: object, keyPath)
    }
}
