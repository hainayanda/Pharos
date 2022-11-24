//
//  Retainable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 16/11/22.
//

import Foundation

// MARK: Retainable

public protocol Retainable: AnyObject {
    
    /// Retain this object as parent of AnyObservable
    /// - Parameter observable: Child
    /// - Returns: given Child
    func asParent<Child: AnyObservable>(of observable: Child) -> Child
    
    /// Retain this object to the given object
    /// - Parameter object: object where this object will be retained
    /// - Returns: Invokable
    @discardableResult
    func retained(by object: AnyObject) -> Invokable
    
    /// Retain this object to the given object exclusively
    /// It will remove any other object retained that have same parent
    /// It will not retain anything if the parent is already removed by ARC since the binding will not worked anyway
    /// - Parameter object: object where this object will be retained
    /// - Returns: Invokable
    @discardableResult
    func retainedExclusively(by object: AnyObject) -> Invokable
    
    /// Retain this object to the source
    /// It will not retain anything if the ancestor is already removed by ARC since the binding will not worked anyway
    /// - Returns: Invokable
    @discardableResult
    func retain() -> Invokable
    
    /// Retain this object to the source until should discard is returning true
    /// - Parameter shouldDiscard: Closure that will be called when the Observable is about to accept a value
    /// - Returns: Invokable
    @discardableResult
    func retainUntil(_ shouldDiscard: @escaping () -> Bool) -> Invokable
    
    /// Discard this retainable
    func discard()
}

public extension Retainable {
    /// Retain this object to the source until get notified by n count
    /// - Parameter nextEventCount: number of event notifies this Retainable
    /// - Returns: Invokable
    @discardableResult
    @inlinable func retainUntil(nextEventCount: Int) -> Invokable {
        var counter: Int = 0
        return retainUntil {
            defer { counter += 1 }
            return counter >= nextEventCount
        }
    }
    
    /// Retain this object to the source until get notified by n count
    /// - Returns: Invokable
    @discardableResult
    @inlinable func retainUntilNextState() -> Invokable {
        retainUntil(nextEventCount: 1)
    }
    
    /// Retain this object to the source until surpassed the timeInterval given
    /// - Parameter timeInterval: timeInterval the object should be retained
    /// - Returns: Invokable
    @discardableResult
    @inlinable func retain(for timeInterval: TimeInterval) -> Invokable {
        let discardTime = Date(timeIntervalSinceNow: timeInterval)
        (DispatchQueue.current ?? .main).asyncAfter(deadline: .now() + timeInterval) { [weak self] in
            self?.discard()
        }
        return retainUntil {
            discardTime <= Date()
        }
    }
}

// MARK: Retainable + Extensions

private var retainingKey: String = "retainKey"

extension Retainable where Self: Invokable {
    /// Retain this object to the given object
    /// - Parameter object: object where this object will be retained
    /// - Returns: Invokable
    @discardableResult
    public func retained(by object: AnyObject) -> Invokable {
        var retained = objc_getAssociatedObject(object, &retainingKey) as? [AnyObject] ?? []
        retained.append(self)
        objc_setAssociatedObject(object, &retainingKey, retained, .OBJC_ASSOCIATION_RETAIN)
        return self
    }
}

// MARK: AnyObservable + release retainables

extension AnyObservable {
    public func release() {
        objc_setAssociatedObject(self, &retainingKey, [], .OBJC_ASSOCIATION_RETAIN)
    }
}

// MARK: RetainableObserver

class RetainableObserver<Value>: Retainable, Observing, Invokable {
    
    public typealias Observer = (Changes<Value>) -> Void
    // to make sure it will only retained child Observable not Boxed, so Observable will only be retained by object where they are declared
    private var retainedParent: InvokableObservable?
    private weak var weakParent: InvokableObservable?
    var parent: AnyObservable? {
        retainedParent ?? weakParent
    }
    weak var child: AnyObservable?
    private var observer: Observer?
    private var shouldDiscard: (() -> Bool)?
    var isDiscarded: Bool { observer == nil }
    
    init(parent: InvokableObservable, observer: @escaping Observer) {
        self.observer = observer
        if parent.isAncestor {
            weakParent = parent
        } else {
            retainedParent = parent
        }
    }
    
    @discardableResult
    func accept(_ changes: Changes<Value>) -> Bool {
        guard !discarded(), changes.canBeConsumed(by: self) else { return false }
        observer?(changes.consumed(by: self))
        return true
    }
    
    func asParent<Child>(of observable: Child) -> Child where Child: AnyObservable {
        child = observable
        retained(by: observable)
        return observable
    }
    
    @inlinable func retain() -> Invokable {
        guard let source = parent?.source else { return self }
        return retained(by: source)
    }
    
    func retainedExclusively(by object: AnyObject) -> Invokable {
        guard let parent = parent else { return self }
        let exclusive = ExclusiveRetainableWrapper(retained: self, source: parent)
        var retained = objc_getAssociatedObject(object, &retainingKey) as? [AnyObject] ?? []
        retained.removeAll {
            ($0 as? ExclusiveRetainableWrapper)?.isComing(from: parent) ?? false
        }
        retained.append(exclusive)
        objc_setAssociatedObject(object, &retainingKey, retained, .OBJC_ASSOCIATION_RETAIN)
        return self
    }
    
    func retainUntil(_ shouldDiscard: @escaping () -> Bool) -> Invokable {
        self.shouldDiscard = shouldDiscard
        return retain()
    }
    
    func discard() {
        retainedParent = nil
        weakParent = nil
        observer = nil
        child = nil
    }
    
    @inlinable func fire() {
        (parent as? InvokableObservable)?.signalFire(from: [ObjectIdentifier(child ?? self)])
    }
    
    private func discarded() -> Bool {
        guard !isDiscarded else { return true }
        guard shouldDiscard?() ?? false else { return false }
        discard()
        return true
    }
}

// MARK: Retainer

public class Retainer {
    
    public init() { }
    
    public func discardAll() {
        objc_setAssociatedObject(self, &retainingKey, [], .OBJC_ASSOCIATION_RETAIN)
    }
}
