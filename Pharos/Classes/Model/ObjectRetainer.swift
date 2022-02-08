//
//  ObjectRetainer.swift
//  Pharos
//
//  Created by Nayanda Haberty on 08/02/22.
//

import Foundation

public protocol ObjectRetainer: AnyObject {
    func retain(_ object: AnyObject)
    func discardAll()
    func discard(_ object: AnyObject)
}

var retainKeysAssicatedKeys = "Pharos_retain_keys"

public extension ObjectRetainer {
    
    internal var retainKeys: [String] {
        (objc_getAssociatedObject(self, &retainKeysAssicatedKeys) as? NSArray)?
            .compactMap { $0 as? String } ?? []
    }
    
    func retain(_ object: AnyObject) {
        var keys = retainKeys
        let objectKey = String(ObjectIdentifier(object).hashValue)
        guard !keys.contains(objectKey) else { return }
        keys.append(objectKey)
        objc_setAssociatedObject(self, &retainKeysAssicatedKeys, NSArray(array: keys), .OBJC_ASSOCIATION_RETAIN)
        objc_setAssociatedObject(self, objectKey, object, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func discardAll() {
        let keys = retainKeys
        for key in keys {
            objc_setAssociatedObject(self, key, nil, .OBJC_ASSOCIATION_RETAIN)
        }
        objc_setAssociatedObject(self, &retainKeysAssicatedKeys, NSArray(), .OBJC_ASSOCIATION_RETAIN)
    }
    
    func discard(_ object: AnyObject) {
        var keys = retainKeys
        let objectKey = String(ObjectIdentifier(object).hashValue)
        keys.removeAll { $0 == objectKey }
        objc_setAssociatedObject(self, objectKey, nil, .OBJC_ASSOCIATION_RETAIN)
        objc_setAssociatedObject(self, &retainKeysAssicatedKeys, NSArray(array: keys), .OBJC_ASSOCIATION_RETAIN)
    }
}
