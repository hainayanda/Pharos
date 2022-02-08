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
    
    internal var retainedObjects: [AnyObject] {
        (objc_getAssociatedObject(self, &retainedObjectsAssicatedKeys) as? NSArray)?
            .compactMap { $0 as AnyObject } ?? []
    }
    
    func retain(_ object: AnyObject) {
        var objects = retainedObjects
        guard !objects.contains(where: { object === $0 }) else { return }
        objects.append(object)
        objc_setAssociatedObject(self, &retainedObjectsAssicatedKeys, NSArray(array: objects), .OBJC_ASSOCIATION_RETAIN)
    }
    
    func discardAllRetained() {
        objc_setAssociatedObject(self, &retainedObjectsAssicatedKeys, nil, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func discard(_ object: AnyObject) {
        var objects = retainedObjects
        objects.removeAll(where: { object === $0 })
        objc_setAssociatedObject(self, &retainedObjectsAssicatedKeys, NSArray(array: objects), .OBJC_ASSOCIATION_RETAIN)
    }
}
