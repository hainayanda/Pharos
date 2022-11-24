//
//  Observable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

// MARK: Observable

open class Observable<Output>: InvokableObservable, Observing {
    public typealias Observer = (Changes<Output>) -> Void
    private weak var _parent: InvokableObservable?
    public var parent: AnyObservable? { _parent }
    
    private var observers: [WeakWrappedObserver<Output>] = []
    public private(set) var isAncestor: Bool
    
    public init() {
        self.isAncestor = true
    }
    
    init(parent: InvokableObservable?) {
        self._parent = parent
        self.isAncestor = parent == nil
    }
    
    init(isAncestor: Bool) {
        self.isAncestor = isAncestor
    }
    
    open func observeChange(_ observer: @escaping Observer) -> Retainable {
        let retainable = RetainableObserver(parent: self, observer: observer)
        let wrapped = WeakWrappedObserver(observer: retainable)
        observers.append(wrapped)
        return retainable
    }
    
    @inlinable public func typeErased() -> Observable<Any> {
        mapped { $0 }
    }
    
    @discardableResult
    /// Send changes to all valid observers if the changes is not already consumed by itself
    /// - Parameter changes: changes to be sent
    /// - Returns: True if changes are sent, otherwise it will be false
    func accept(_ changes: Changes<Output>) -> Bool {
        guard changes.canBeConsumed(by: self) else { return false }
        send(changes: changes.consumed(by: self))
        return true
    }
    
    /// Send changes to all the valid observers no matter what
    /// - Parameter changes: changes to be sent
    func send(changes: Changes<Output>) {
        observers = observers.filter {
            guard $0.valid else { return false }
            $0.accept(changes)
            return true
        }
    }
    
    public func relayChanges(to otherObservable: Observable<Output>) -> Retainable {
        observeChange { [weak otherObservable] changes in
            guard let otherObservable = otherObservable else { return }
            otherObservable.accept(changes)
        }
    }
    
    public func bind(with otherObservable: Observable<Output>) -> Retainable {
        let otherRetainable = otherObservable.relayChanges(to: self)
        let myRetainable = relayChanges(to: otherObservable)
        return RetainableGroup(retainables: [otherRetainable, myRetainable])
    }
    
    func signalFire(from triggers: [ObjectIdentifier]) {
        var triggers = triggers
        triggers.append(ObjectIdentifier(self))
        _parent?.signalFire(from: triggers)
    }
    
    public func fire() {
        _parent?.signalFire(from: [ObjectIdentifier(self)])
    }
}

extension Observable {
    @inlinable public func observe(_ observer: @escaping (Output) -> Void) -> Retainable {
        observeChange { observer($0.new) }
    }
}
