//
//  DispatchQueue+Extensions.swift
//  Chary
//
//  Copied and edited from https://stackoverflow.com/questions/17475002/get-current-dispatch-queue
//

import Foundation

// MARK: Detection

struct QueueReference {
    weak var queue: DispatchQueue?
}

fileprivate let detectionKey = DispatchSpecificKey<QueueReference>()

extension DispatchQueue {
    
    /// Try to get current queue. It will only show the one registered or accessible from OperationQueue.current, or SystemThread
    public static var current: DispatchQueue? {
        registerSystemDetection()
        if let registeredQueue = getSpecific(key: detectionKey)?.queue {
            return registeredQueue
        } else if let fromOpQ = OperationQueue.current?.underlyingQueue {
            fromOpQ.registerDetection()
            return fromOpQ
        } else if Thread.isMainThread {
            let main = DispatchQueue.main
            main.registerDetection()
            return main
        }
        return nil
    }
    
    /// Register all systems DispatchQueue for detection including: main, global, global background, global default, global user initiated, global user interactivity, global utiliity
    public static func registerSystemDetection() {
        [
            DispatchQueue.main, DispatchQueue.global(),
            DispatchQueue.global(qos: .background), DispatchQueue.global(qos: .default),
            DispatchQueue.global(qos: .unspecified), DispatchQueue.global(qos: .userInitiated),
            DispatchQueue.global(qos: .userInteractive), DispatchQueue.global(qos: .utility)
            
        ].forEach {
            $0.registerDetection()
        }
    }
    
    /// Register the current DispatchQueue for detection
    public func registerDetection() {
        self.setSpecific(key: detectionKey, value: QueueReference(queue: self))
    }
}

// MARK: SafeSync

extension DispatchQueue {
    
    /// Perform safe synchronous task. It will run the block right away if turns out its on the same queue as the target
    /// - Parameter block: The work item to be invoked on the queue.
    /// - returns the value returned by the work item.
    public func safeSync<Return>(execute block: () -> Return) -> Return {
        ifAtDifferentQueue {
            sync(execute: block)
        } ifNot: {
            block()
        }
    }
    
    /// Perform safe synchronous task. It will run the block right away if turns out its on the same queue as the target
    /// - Parameter workItem: The work item to be invoked on the queue.
    public func safeSync(execute workItem: DispatchWorkItem) {
        ifAtDifferentQueue {
            sync(execute: workItem)
        } ifNot: {
            workItem.perform()
        }
    }
    
    /// Perform asynchronous task if in different queue than the target. It will run the block right away if turns out its on the same queue as the target
    /// - Parameter block: The work item to be invoked on the queue.
    public func asyncIfNeeded(execute block: @escaping () -> Void) {
        ifAtDifferentQueue {
            async(execute: block)
        } ifNot: {
            block()
        }
    }
    
    /// Perform asynchronous task if in different queue than the target. It will run the block right away if turns out its on the same queue as the target
    /// - Parameter workItem: The work item to be invoked on the queue.
    public func asyncIfNeeded(execute workItem: DispatchWorkItem) {
        ifAtDifferentQueue {
            async(execute: workItem)
        } ifNot: {
            workItem.perform()
        }
    }
    
    /// Perform queue check to determined if its in same queue or not. The it will run one of the block regarding of the current queue
    /// - Parameters:
    ///   - block: Block that will be run if current queue different than the target
    ///   - doElse: Block that will be run if current queue same than the target
    /// - Returns: The value returned by the block
    public func ifAtDifferentQueue<Return>(do block: () -> Return, ifNot doElse: () -> Return) -> Return {
        ifAtSameQueue(do: doElse, ifNot: block)
    }
    
    /// Perform queue check to determined if its in same queue or not. The it will run one of the block regarding of the current queue
    /// - Parameters:
    ///   - block: Block that will be run if current queue same than the target
    ///   - doElse: Block that will be run if current queue different than the target
    /// - Returns: The value returned by the block
    public func ifAtSameQueue<Return>(do block: () -> Return, ifNot doElse: () -> Return) -> Return {
        registerDetection()
        guard DispatchQueue.current != self else {
            return block()
        }
        return doElse()
    }
}
