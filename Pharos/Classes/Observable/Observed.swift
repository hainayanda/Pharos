//
//  ObservedRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation
import Chary

enum RelayOperationStatus {
    case discarded
    case relaying
    case suspended
    case idle
}

open class Observed<State>: ObservedSubject, ChildObservable {
    public typealias Observer = (Changes<State>, PharosContext) -> Void
    
    let observer: Observer
    
    weak var source: Observable<State>?
    var parent: AnyObject? { (source as? ChildObservable)?.parent ?? source }
    
    var queue: DispatchQueue? {
        didSet {
            queue?.registerDetection()
        }
    }
    var preferAsync: Bool = false
    var delay: TimeInterval?
    var shouldDiscardSelf: (Changes<State>) -> Bool = { _ in false }
    let contextRetainer: ContextRetainer
    
    @Atomic var status: RelayOperationStatus = .idle {
        didSet {
            if oldValue == .discarded {
                status = .discarded
                return
            }
            switch status {
            case .idle:
                relayPendingChanges()
            default:
                return
            }
        }
    }
    @Atomic var pendingChanges: Changes<RelayedState>?
    
    var canRelay: Bool {
        switch status {
        case .idle:
            return true
        default:
            return false
        }
    }
    
    public init(source: Observable<State>, retainer: ContextRetainer, observer: @escaping Observer) {
        self.source = source
        self.observer = observer
        self.contextRetainer = retainer
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
        source?.retain(retainer: self.contextRetainer.added(with: self))
        return RelayInvoker(relay: self)
    }
    
    @discardableResult
    open func retained(by retainer: ObjectRetainer) -> Invokable {
        retainer.retain(self.contextRetainer.added(with: self))
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
        contextRetainer.discard(object: self)
        self.source?.discard(child: self)
        self.status = .discarded
    }
}

extension Observed: StateRelay {
    public typealias RelayedState = State
    func relay(changes: Changes<RelayedState>, context: PharosContext) {
        context.safeRun(for: self) {
            guard canRelay else {
                putInPending(for: changes)
                return
            }
            self.status = .relaying
            if preferAsync {
                relayAsync(for: changes, context: context)
            } else {
                relaySyncIfCould(for: changes, context: context)
            }
            finishRelay(for: changes)
        }
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
            self?.status = .idle
        }
    }
    
    func relayPendingChanges() {
        guard let pending = dequeuePendingChanges() else { return }
        self.relay(changes: pending, context: PharosContext())
    }
    
    func relayAsync(for changes: Changes<RelayedState>, context: PharosContext) {
        let observer = self.observer
        let queue = (self.queue ?? .current) ?? .main
        queue.async {
            observer(changes, context)
        }
    }
    
    func relaySyncIfCould(for changes: Changes<RelayedState>, context: PharosContext) {
        let observer = self.observer
        guard let queue = self.queue else {
            observer(changes, context)
            return
        }
        queue.asyncIfNeeded {
            observer(changes, context)
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
