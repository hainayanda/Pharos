//
//  ObservedRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

enum RelayOperationStatus {
    case relaying
    case suspended
    case idle
}

open class Observed<State>: ObservedSubject, ChildObservable {
    typealias Observer = (Changes<State>) -> Void
    
    let observer: Observer
    
    weak var source: Observable<State>?
    var parent: AnyObject? { (source as? ChildObservable)?.parent ?? source }
    
    var queue: DispatchQueue?
    var preferAsync: Bool = false
    var delay: TimeInterval?
    var shouldDiscardSelf: (Changes<State>) -> Bool = { _ in false }
    
    @Atomic var status: RelayOperationStatus = .idle
    @Atomic var pendingChanges: Changes<RelayedState>?
    
    var canRelay: Bool {
        switch status {
        case .idle:
            return true
        default:
            return false
        }
    }
    
    init(source: Observable<State>, observer: @escaping Observer) {
        self.source = source
        self.observer = observer
    }
    
    open func multipleSetDelayed(by delay: TimeInterval) -> Self {
        self.delay = delay
        return self
    }
    
    open func observe(on queue: DispatchQueue) -> Self {
        self.queue = queue
        return self
    }
    
    open func asynchronously() -> Self {
        preferAsync = true
        return self
    }
    
    @discardableResult
    open func retain() -> Invokable {
        source?.retain(relay: self)
        return RelayInvoker(relay: self)
    }
    
    @discardableResult
    open func retained(by retainer: ObjectRetainer) -> Invokable {
        source?.retainWeakly(relay: self, managedBy: retainer)
        return RelayInvoker(relay: self)
    }
    
    @discardableResult
    open func retain(for timeInterval: TimeInterval) -> Invokable {
        let invokable = retain()
        (DispatchQueue.current ?? .main).asyncAfter(deadline: .now() + timeInterval) { [weak self] in
            guard let self = self else { return }
            self.discardSelf()
        }
        return invokable
    }
    
    @discardableResult
    open func retainUntil(lastStateMatch: @escaping (Changes<State>) -> Bool) -> Invokable {
        shouldDiscardSelf = lastStateMatch
        return retain()
    }
    
    func discardSelf() {
        self.source?.temporaryRetainer.discard(self)
        self.source?.relayGroup.remove(self)
    }
}

extension Observed: StateRelay {
    public typealias RelayedState = State
    func relay(changes: Changes<RelayedState>) {
        guard canRelay else {
            putInPending(for: changes)
            return
        }
        self.status = .relaying
        if preferAsync {
            relayAsync(for: changes)
        } else {
            relaySyncIfCould(for: changes)
        }
        finishRelay(for: changes)
    }
    
    func relay(changes: Changes<RelayedState>, skip: AnyStateRelay) {
        if self === skip { return }
        relay(changes: changes)
    }
    
    func finishRelay(for changes: Changes<RelayedState>) {
        guard !shouldDiscardSelf(changes) else {
            self.status = .idle
            discardSelf()
            return
        }
        guard let delay = self.delay else {
            self.status = .idle
            return
        }
        self.status = .suspended
        let queue = (self.queue ?? .current) ?? .main
        queue.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self, let pending = self.dequeuePendingChanges() else { return }
            self.status = .idle
            self.relay(changes: pending)
        }
    }
    
    func relayAsync(for changes: Changes<RelayedState>) {
        let observer = self.observer
        let queue = (self.queue ?? .current) ?? .main
        queue.async {
            observer(changes)
        }
    }
    
    func relaySyncIfCould(for changes: Changes<RelayedState>) {
        let observer = self.observer
        guard let queue = self.queue else {
            observer(changes)
            return
        }
        queue.asyncIfInDifferentQueue {
            observer(changes)
        }
    }
    
    func putInPending(for changes: Changes<RelayedState>) {
        let old = self.pendingChanges?.old ?? changes.old
        self.pendingChanges = Changes(
            old: old,
            new: changes.new,
            source: changes.source
        )
    }
    
    func dequeuePendingChanges() -> Changes<RelayedState>? {
        defer {
            self.pendingChanges = nil
        }
        return pendingChanges
    }
    
    func isSameRelay(with anotherRelay: AnyStateRelay) -> Bool {
        self === anotherRelay
    }
}
