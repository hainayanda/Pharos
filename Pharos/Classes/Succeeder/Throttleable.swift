//
//  Throttleable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation
import Chary
#if canImport(UIKit)
import UIKit
#endif

public protocol ThrottleableObservable: Invokable {
    associatedtype Output
    
    func throttled(by minimumInterval: TimeInterval) -> Observable<Output>
}

extension ThrottleableObservable where Self: ObservableProtocol, Self: ObjectRetainer {
    public func throttled(by minimumInterval: TimeInterval) -> Observable<Output> {
        succeeding(with: ThrottledObservable(parent: self, minimumInterval: minimumInterval))
    }
    
#if canImport(UIKit)
    @inlinable public func smoothThrottled() -> Observable<Output> {
        let frequency = Double(UIScreen.main.maximumFramesPerSecond) * 2
        return throttled(by: 1/frequency)
    }
#endif
}

extension Observable: ThrottleableObservable { }

final class ThrottledObservable<Output>: SucceederObservable<Output, Output> {
    
    let interval: TimeInterval
    lazy var syncQueue = DispatchQueue(label: UUID().uuidString)
    @Atomic var pending: Changes<Output>?
    @Atomic var throttleTime: Date = .distantPast
    
    private lazy var _recentState: Output? = (parent as? Observable<Input>)?.recentState
    @inlinable override var recentState: Output? { _recentState }
    
    @inlinable init(parent: ObserverParent, minimumInterval: TimeInterval) {
        self.interval = minimumInterval
        super.init(parent: parent)
        $pending = syncQueue
        $throttleTime = syncQueue
    }
    
    @inlinable override func accept(changes: Changes<Output>) {
        let currentQueue = (DispatchQueue.current ?? DispatchQueue.main)
        syncQueue.safeSync {
            guard abs(throttleTime.timeIntervalSinceNow) >= interval else {
                pending = changes.withNoOld()
                return
            }
            throttleTime = Date()
            super.sendIfNeeded(for: changes)
            _recentState = changes.new
            let newOldValue = changes.new
            currentQueue.asyncAfter(deadline: .now() + interval) { [weak self] in
                guard let self = self else { return }
                guard let pending = self.pending else { return }
                self.pending = nil
                self.accept(changes: pending.with(old: newOldValue))
            }
        }
    }
}
