//
//  RelayOperationHandler.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public protocol RelayHandler {
    associatedtype Value
    @discardableResult
    func relay(changes: Changes<Value>) -> Bool
}

protocol RelayOperationHandler: RelayHandler {
    typealias Consumer = (Changes<Value>) -> Void
    var dispatcher: DispatchQueue? { get set }
    var syncIfPossible: Bool { get set }
    var delay: TimeInterval? { get set }
    var status: RelayOperationStatus { get set }
    var consumer: Consumer? { get set }
}

enum RelayOperationStatus {
    case relaying
    case idle
}

final class RelayChangeHandler<Value>: RelayOperationHandler {
    typealias Task = () -> Void
    typealias Consumer = (Changes<Value>) -> Void
    
    var canRelay: Bool {
        consumer != nil
    }
    
    private var _consumer: Consumer?
    var consumer: Consumer? {
        get {
            locked { _consumer }
        }
        set {
            locked { _consumer = newValue }
        }
    }
    
    private var _delay: TimeInterval?
    var delay: TimeInterval? {
        get {
            locked { _delay }
        }
        set {
            locked { _delay = newValue }
        }
    }
    
    private var _syncIfPossible: Bool = false
    var syncIfPossible: Bool {
        get {
            locked { _syncIfPossible }
        }
        set {
            locked { _syncIfPossible = newValue }
        }
    }
    
    private var _status: RelayOperationStatus = .idle
    var status: RelayOperationStatus {
        get {
            locked { _status }
        }
        set {
            let oldValue = status
            locked { _status = newValue }
            guard oldValue != newValue,
                  newValue == .idle,
                  let pendingTask = dequeuePendingTask() else { return }
            pendingTask()
        }
    }
    
    private var _dispatcher: DispatchQueue?
    var dispatcher: DispatchQueue? {
        get {
            locked { _dispatcher }
        }
        set {
            locked { _dispatcher = newValue }
            guard let value = newValue else { return }
            DispatchQueue.registerDetection(of: value)
        }
    }
    
    private var _pendingTask: Task?
    var pendingTask: Task? {
        get {
            locked { _pendingTask }
        }
        set {
            locked { _pendingTask = newValue }
        }
    }
    
    private var lock: NSLock = .init()
    
    @discardableResult
    func relay(changes: Changes<Value>) -> Bool {
        guard canRelay else { return false }
        guard status == .idle else {
            pendingTask = { [weak self] in
                self?.consume(changes: changes)
            }
            return true
        }
        return consume(changes: changes)
    }
    
    @discardableResult
    private func consume(changes: Changes<Value>) -> Bool {
        guard let consumer = self.consumer else {
            return false
        }
        status = .relaying
        guard let dispatcher = self.dispatcher else {
            consumeAction(consumer: consumer, changes: changes)
            return true
        }
        guard syncIfPossible else {
            dispatcher.async { [weak self] in
                self?.consumeAction(consumer: consumer, changes: changes)
            }
            return true
        }
        runSyncIfPossible(on: dispatcher) { [weak self] in
            self?.consumeAction(consumer: consumer, changes: changes)
        }
        return true
    }
    
    private func consumeAction(consumer: Consumer, changes: Changes<Value>) {
        consumer(changes)
        guard let delay = delay else {
            status = .idle
            return
        }
        (DispatchQueue.current ?? .main).asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.status = .idle
        }
    }
    
    private func dequeuePendingTask() -> Task? {
        guard let pendingTask = self.pendingTask else {
            return nil
        }
        self.pendingTask = nil
        return pendingTask
    }
    
    private func locked<Return>(_ closure: () -> Return) -> Return {
        lock.lock()
        defer {
            lock.unlock()
        }
        return closure()
    }
    
}
