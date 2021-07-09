//
//  DipatchQueue+Extensions.swift
//  Ergo
//
//  Copied and edited from https://stackoverflow.com/questions/17475002/get-current-dispatch-queue
//
import Foundation

/// Perform task in given dispatcher. If current queue is same as given dispatcher, it will run synchronously.
/// - Parameters:
///   - dispatcher: DispatchQueue where task run
///   - work: Task to run
public func runSyncIfPossible(on dispatcher: DispatchQueue, execute work: @escaping () -> Void) {
    let currentQueue: DispatchQueue = .current ?? .main
    guard currentQueue == dispatcher else {
        dispatcher.async(execute: work)
        return
    }
    work()
}

extension DispatchQueue {
    
    static let key: DispatchSpecificKey<QueueReference> = {
        let key = DispatchSpecificKey<QueueReference>()
        setupSystemQueuesDetection(key: key)
        return key
    }()
    
    struct QueueReference {
        weak var queue: DispatchQueue?
    }
    
    static func registerDetection(of queues: [DispatchQueue], key: DispatchSpecificKey<QueueReference>) {
        queues.forEach { $0.setSpecific(key: key, value: QueueReference(queue: $0)) }
    }
    
    static func setupSystemQueuesDetection(key: DispatchSpecificKey<QueueReference>) {
        let queues: [DispatchQueue] = [
            .main,
            .global(qos: .background),
            .global(qos: .default),
            .global(qos: .unspecified),
            .global(qos: .userInitiated),
            .global(qos: .userInteractive),
            .global(qos: .utility)
        ]
        registerDetection(of: queues, key: key)
    }
}

public extension DispatchQueue {
    static func registerDetection(of queue: DispatchQueue) {
        registerDetection(of: [queue], key: key)
    }
    
    static var currentQueueLabel: String? { current?.label }
    static var current: DispatchQueue? { getSpecific(key: key)?.queue }
}
