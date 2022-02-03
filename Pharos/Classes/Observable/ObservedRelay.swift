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

open class ObservedRelay<Observed>: ObservedObservable {
    typealias Observer = (Changes<Observed>) -> Void
    
    let observer: Observer
    
    weak var source: ObservableValue<Observed>?
    
    var queue: DispatchQueue?
    var preferSync: Bool = true
    var delay: TimeInterval?
    
    @Atomic var status: RelayOperationStatus = .idle
    @Atomic var pendingChanges: Changes<Relayed>?
    
    var canRelay: Bool {
        switch status {
        case .idle:
            return true
        default:
            return false
        }
    }
    
    init(source: ObservableValue<Observed>, observer: @escaping Observer) {
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
    
    open func alwaysAsync() -> Self {
        preferSync = false
        return self
    }
    
    @discardableResult
    open func retain() -> Invokable {
        source?.retain(relay: self)
        return RelayInvoker(relay: self)
    }
    
    @discardableResult
    open func retained(by retainer: Retainer) -> Invokable {
        source?.retainWeakly(relay: self, managedBy: retainer)
        return RelayInvoker(relay: self)
    }
}

extension ObservedRelay: Relay {
    typealias Relayed = Observed
    func relay(changes: Changes<Relayed>) {
        guard canRelay else {
            putInPending(for: changes)
            return
        }
        self.status = .relaying
        if preferSync {
            relaySync(for: changes)
        } else {
            relayAsync(for: changes)
        }
        finishRelay()
    }
    
    func relay(changes: Changes<Relayed>, skip: AnyRelay) {
        if self === skip { return }
        relay(changes: changes)
    }
    
    func finishRelay() {
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
    
    func relayAsync(for changes: Changes<Relayed>) {
        let observer = self.observer
        let queue = (self.queue ?? .current) ?? .main
        queue.async {
            observer(changes)
        }
    }
    
    func relaySync(for changes: Changes<Relayed>) {
        let observer = self.observer
        guard let queue = self.queue else {
            observer(changes)
            return
        }
        syncIfPossible(on: queue) {
            observer(changes)
        }
    }
    
    func putInPending(for changes: Changes<Relayed>) {
        let old = self.pendingChanges?.old ?? changes.old
        self.pendingChanges = Changes(
            old: old,
            new: changes.new,
            source: changes.source
        )
    }
    
    func dequeuePendingChanges() -> Changes<Relayed>? {
        defer {
            self.pendingChanges = nil
        }
        return pendingChanges
    }
    
    func isSameRelay(with anotherRelay: AnyRelay) -> Bool {
        self === anotherRelay
    }
}
