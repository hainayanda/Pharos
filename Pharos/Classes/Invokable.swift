//
//  Invokable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

protocol InvokableChild: Retainable, Invokable {
    var parent: ObserverParentTemporaryRetainer { get set }
}

protocol ObservingObservable: Invokable, Observing {
    var parent: ObserverParent? { get set }
}

public protocol Invokable: AnyObject {
    func fire()
}

extension Invokable {
    func fire(after delay: TimeInterval) {
        (DispatchQueue.current ?? DispatchQueue.main)
            .asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.fire()
            }
    }
}

extension InvokableChild {
    
    @discardableResult
    public func retained(by object: AnyObject) -> Invokable {
        defer { parent.releaseParent() }
        var retained = retained(for: object)
        retained.append(self)
        retain(allObjects: retained, with: object)
        return self
    }
    
    @discardableResult
    public func retain() -> Invokable {
        defer { parent.releaseParent() }
        guard let source = parent.instance else { return self }
        retained(by: source)
        return self
    }
    
    func retained(for object: AnyObject) -> [AnyObject] {
        objc_getAssociatedObject(object, &retainingKey) as? [AnyObject] ?? []
    }
    
    func retain(allObjects: [AnyObject], with object: AnyObject) {
        objc_setAssociatedObject(object, &retainingKey, allObjects, .OBJC_ASSOCIATION_RETAIN)
    }
    
    public func fire() {
        parent.instance?.fire()
    }
}
