//
//  Observed.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

public class Observed<Input>: InvokableChild, Observing, Invokable {
    
    var queue: DispatchQueue?
    var asynchronously: Bool = false
    var observer: ((Changes<Input>) -> Void)?
    var parent: ObserverParentTemporaryRetainer
    var shouldDiscardClosure: ((Changes<Input>) -> Bool)?
    var valid: Bool { observer != nil }
    
    init(source: ObserverParent, observer: @escaping (Changes<Input>) -> Void) {
        self.observer = observer
        self.parent = .init(instance: source)
    }
    
    public func observe(on queue: DispatchQueue, asynchronously: Bool = false) -> Observed<Input> {
        self.asynchronously = asynchronously
        self.queue = queue
        return self
    }
    
    func accept(changes: Changes<Input>) {
        guard valid else { return }
        guard !shouldDiscard(for: changes) else {
            parent.instance?.discard(self)
            self.observer = nil
            return
        }
        sendToObserver(changes)
    }
    
    func sendToObserver(_ changes: Changes<Input>) {
        guard let observer = observer else { return }
        guard let queue = queue else {
            observer(changes)
            return
        }
        guard asynchronously else {
            queue.asyncIfNeeded {
                observer(changes)
            }
            return
        }
        queue.async {
            observer(changes)
        }
    }
    
    func shouldDiscard(for changes: Changes<Input>) -> Bool {
        guard let conditionMet = shouldDiscardClosure else { return false }
        return conditionMet(changes)
    }
    
    @discardableResult
    public func retainUntil(_ conditionMet: @escaping (Changes<Input>) -> Bool) -> Invokable {
        self.shouldDiscardClosure = conditionMet
        return retain()
    }
}

extension Observed {
    @inlinable public func observeOnMain(asynchronously: Bool = false) -> Observed<Input> {
        observe(on: .main)
    }
    
    @inlinable public func observeOnBackground() -> Observed<Input> {
        observe(on: .global(qos: .background), asynchronously: true)
    }
    
    @discardableResult
    @inlinable public func retainUntilNextState() -> Invokable {
        retainUntil(nextEventCount: 1)
    }
    
    @discardableResult
    @inlinable public func retainUntil(nextEventCount count: Int) -> Invokable {
        var observeCount: Int = 0
        return retainUntil { _ in
            defer { observeCount += 1 }
            return observeCount >= count
        }
    }
    
    @discardableResult
    @inlinable public func retain(for timeInterval: TimeInterval) -> Invokable {
        let timeOfRetain = Date()
        return retainUntil { _ in
            abs(timeOfRetain.timeIntervalSinceNow) > timeInterval
        }
    }
}

extension Observed where Input: Equatable {
    @discardableResult
    @inlinable public func retainUntil(found: Input) -> Invokable {
        return retainUntil { changes in
            changes.new == found
        }
    }
}

extension Observed where Input: AnyObject {
    @discardableResult
    @inlinable public func retainUntilObject(found: Input) -> Invokable {
        return retainUntil { changes in
            changes.new === found
        }
    }
}
