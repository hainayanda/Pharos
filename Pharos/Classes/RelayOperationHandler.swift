//
//  RelayOperationHandler.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

protocol RelayOperationHandler {
    associatedtype Value
    func relay(changes: Changes<Value>)
}

class RelayDispatchHandler<Value>: RelayOperationHandler {
    typealias Consumer = (Changes<Value>) -> Void
    var operationQueue: OperationQueue?
    var dispatcher: DispatchQueue? {
        didSet {
            guard let dispatcher = self.dispatcher else {
                operationQueue = nil
                return
            }
            let operationQueue = OperationQueue()
            operationQueue.name = uniqueKey
            operationQueue.maxConcurrentOperationCount = 1
            operationQueue.underlyingQueue = dispatcher
            self.operationQueue = operationQueue
        }
    }
    var syncIfPossible: Bool = false
    var delay: TimeInterval?
    var consumer: Consumer?
    
    var lock: NSLock = .init()
    private var _isRelaying: Bool = false
    var isRelaying: Bool {
        get {
            lockRun { _isRelaying }
        }
        set {
            lockRun { _isRelaying = newValue }
        }
    }
    var latestRelayTime: Date = .distantPast
    var _pendingChanges: Changes<Value>?
    var pendingChanges: Changes<Value>? {
        get {
            _pendingChanges
        }
        set {
            guard let pending = newValue else {
                _pendingChanges = nil
                return
            }
            guard let oldPending = _pendingChanges else {
                _pendingChanges = pending
                return
            }
            _pendingChanges = .init(
                old: oldPending.old,
                new: pending.new,
                source: pending.source
            )
        }
    }
    
    var havePendingChanges: Bool {
        lockRun { pendingChanges } != nil
    }
    
    var maySynchronized: Bool {
        OperationQueue.current?.underlyingQueue == dispatcher
    }
    
    var shouldSynchronous: Bool {
        maySynchronized && syncIfPossible
    }
    
    var shouldAsynchronous: Bool {
        !shouldSynchronous
    }
    
    var delayDispatcher: DispatchQueue {
        (dispatcher ?? OperationQueue.current?.underlyingQueue) ?? .main
    }
    
    var uniqueKey: String = UUID().uuidString
    
    func relay(changes: Changes<Value>) {
        guard let consumer = self.consumer else { return }
        guard let delay = delay,
              latestRelayTime.addingTimeInterval(delay) > Date() else {
            latestRelayTime = Date()
            run { consumer(changes) }
            return
        }
        defer {
            set(pendingChanges: changes)
        }
        guard !havePendingChanges else {
            return
        }
        let timeIntervalToFire = max(latestRelayTime.addingTimeInterval(delay).timeIntervalSinceNow, 0)
        delayDispatcher.asyncAfter(deadline: .now() + timeIntervalToFire) { [weak self] in
            guard let self = self else { return }
            let latestChanges = self.getAndRemovePendingChanges() ?? changes
            self.relay(changes: latestChanges)
        }
    }
    
    func run(operation: @escaping () -> Void) {
        runWhenNotRelaying { done in
            operationQueue?.cancelAllOperations()
            guard let operationQueue = self.operationQueue, shouldAsynchronous else {
                operation()
                done()
                return
            }
            operationQueue.addOperation(RelayOperation {
                operation()
                done()
            })
        }
    }
    
    func runWhenNotRelaying(runner: (@escaping () -> Void) -> Void) {
        guard !isRelaying else { return }
        isRelaying = true
        runner { [weak self] in
            self?.isRelaying = false
        }
    }
    
    func set(pendingChanges: Changes<Value>) {
        lockRun {
            self.pendingChanges = pendingChanges
        }
    }
    
    func getAndRemovePendingChanges() -> Changes<Value>? {
        lockRun {
            defer {
                pendingChanges = nil
            }
            return pendingChanges
        }
    }
    
    func lockRun<Return>(_ closure: () -> Return) -> Return {
        lock.lock()
        defer {
            lock.unlock()
        }
        return closure()
    }
    
}

extension RelayDispatchHandler {
    
    enum RelayOperationState {
        case idle
        case running
        case completed
        case cancelled
    }
    
    class RelayOperation: Operation {
        var closure: () -> Void
        var state: RelayOperationState = .idle
        override var isAsynchronous: Bool { false }
        override var isConcurrent: Bool { false }
        override var isReady: Bool { state == .idle }
        override var isExecuting: Bool { state == .running }
        override var isCancelled: Bool { state == .cancelled }
        override var isFinished: Bool { state == .completed || state == .cancelled }
        
        init(_ closure: @escaping () -> Void) {
            self.closure = closure
            super.init()
        }
        
        override func main() {
            defer {
                state = .completed
            }
            guard !isCancelled else {
                return
            }
            state = .running
            closure()
        }
        
        override func cancel() {
            state = .cancelled
        }
        
    }
}
