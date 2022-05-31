//
//  Array+Extensions.swift
//  Pharos
//
//  Created by Nayanda Haberty on 31/05/22.
//

import Foundation

extension Dictionary where Key == ObjectIdentifier, Value == AnyObject {
    
    mutating func append(_ object: Value) {
        self[ObjectIdentifier(object)] = object
    }
    
    @discardableResult
    mutating func remove(_ object: Value) -> Bool {
        guard contains(object) else { return false }
        self[ObjectIdentifier(object)] = nil
        return true
    }
    
    func contains(_ object: Value) -> Bool {
        self[ObjectIdentifier(object)] != nil
    }
    
}

extension Dictionary where Key == ObjectIdentifier, Value == AnyStateRelay {
    
    mutating func append(_ object: Value) {
        self[ObjectIdentifier(object)] = object
    }
    
    @discardableResult
    mutating func remove(_ object: Value) -> Bool {
        guard contains(object) else { return false }
        self[ObjectIdentifier(object)] = nil
        return true
    }
    
    func contains(_ object: Value) -> Bool {
        self[ObjectIdentifier(object)] != nil
    }
    
}
