//
//  Observable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

open class Observable<Output>: ObservableProtocol, ObserverParent {
    
    var observers: [WeakWrappedObserver<Output>] = []
    public var recentState: Output? { return nil }
    
    open func observeChange(_ observer: @escaping (Changes<Output>) -> Void) -> Observed<Output> {
        let retainableListener = Observed(source: self) { changes in
            observer(changes)
        }
        observers.append(WeakWrappedObserver(wrapped: retainableListener))
        return retainableListener
    }
    
    @discardableResult
    /// Send changes to all valid observers if the changes is not already consumed by itself
    /// - Parameter changes: changes to be sent
    /// - Returns: True if changes are sent, otherwise it will be false
    open func sendIfNeeded(for changes: Changes<Output>) -> Bool {
        guard !changes.alreadyConsumed(by: self) else { return false }
        send(changes: changes.consumed(by: self))
        return true
    }
    
    /// Send changes to all the valid observers no matter what
    /// - Parameter changes: changes to be sent
    open func send(changes: Changes<Output>) {
        observers.lazy.filter { $0.valid }.forEach {
            $0.accept(changes: changes)
        }
    }
    
    public func relayChanges(to otherBox: Observable<Output>) -> Observed<Output> {
        observeChange { [weak otherBox] changes in
            guard let otherBox = otherBox else { return }
            otherBox.sendIfNeeded(for: changes)
        }
    }
    
    public func bind(with otherBox: Observable<Output>) -> Observed<Output> {
        otherBox.relayChanges(to: self).retained(by: self)
        return relayChanges(to: otherBox)
    }
    
    open func fire() { }
}
