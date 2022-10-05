//
//  ObjectRetainer.swift
//  Pharos
//
//  Created by Nayanda Haberty on 08/02/22.
//

import Foundation

public protocol ObjectRetainer: AnyObject {
    func findRetained(where match: (AnyObject) -> Bool) -> AnyObject?
    func retain(_ object: AnyObject)
    func discardAll()
    func discard(_ object: AnyObject)
}

var retainingKey: String = "retainingKey"

extension ObjectRetainer {
    public func retain(_ object: AnyObject) {
        var retained = objc_getAssociatedObject(self, &retainingKey) as? [AnyObject] ?? []
        retained.append(object)
        objc_setAssociatedObject(self, &retainingKey, retained, .OBJC_ASSOCIATION_RETAIN)
    }
    
    public func discardAll() {
        objc_setAssociatedObject(self, &retainingKey, [AnyObject](), .OBJC_ASSOCIATION_RETAIN)
    }
    
    public func discard(_ object: AnyObject) {
        var retained = objc_getAssociatedObject(self, &retainingKey) as? [AnyObject] ?? []
        retained.removeAll { $0 === object }
        objc_setAssociatedObject(self, &retainingKey, retained, .OBJC_ASSOCIATION_RETAIN)
    }
    
    public func findRetained(where match: (AnyObject) -> Bool) -> AnyObject? {
        let retained = objc_getAssociatedObject(self, &retainingKey) as? [AnyObject] ?? []
        return retained.first(where: match)
    }
    
    @available(*, deprecated, renamed: "discardAll")
    public func discardAllRetained() {
        discardAll()
    }
}

public class Retainer: ObjectRetainer {
    public init() { }
}
