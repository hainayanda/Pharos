//
//  ObjectRetainer.swift
//  Pharos
//
//  Created by Nayanda Haberty on 08/02/22.
//

import Foundation

public protocol ObjectRetainer: AnyObject {
    func retain(_ object: AnyObject)
    func discardAllRetained()
    func discard(_ object: AnyObject)
}

var retainedObjectsAssicatedKeys = "Pharos_retain_objects"

public extension ObjectRetainer {
    
    internal var retainedObjects: [ObjectIdentifier: AnyObject] {
        get {
            (objc_getAssociatedObject(self, &retainedObjectsAssicatedKeys) as? [ObjectIdentifier: AnyObject]) ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &retainedObjectsAssicatedKeys, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func retain(_ object: AnyObject) {
        retainedObjects.append(object)
    }
    
    func discardAllRetained() {
        retainedObjects = [:]
    }
    
    func discard(_ object: AnyObject) {
        retainedObjects.remove(object)
    }
}
