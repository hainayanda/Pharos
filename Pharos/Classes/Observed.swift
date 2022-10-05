//
//  Observed.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

public class Observed<Input>: InvokableChild, Observing, Invokable {
    
    var observer: ((Changes<Input>) -> Void)?
    var parent: ObserverParentTemporaryRetainer
    var shouldDiscardClosure: ((Changes<Input>) -> Bool)?
    
    init(source: ObserverParent, observer: @escaping (Changes<Input>) -> Void) {
        self.observer = observer
        self.parent = .init(instance: source)
    }
    
    func accept(changes: Changes<Input>) {
        guard let observer = observer else { return }
        guard !shouldDiscard(for: changes) else {
            parent.instance?.discard(self)
            self.observer = nil
            return
        }
        observer(changes)
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
    @discardableResult
    public func retainUntilNextState() -> Invokable {
        retainUntil(nextEventCount: 1)
    }
    
    @discardableResult
    public func retainUntil(nextEventCount count: Int) -> Invokable {
        var observeCount: Int = 0
        return retainUntil { _ in
            defer { observeCount += 1 }
            return observeCount >= count
        }
    }
    
    @discardableResult
    public func retain(for timeInterval: TimeInterval) -> Invokable {
        let timeOfRetain = Date()
        return retainUntil { _ in
            abs(timeOfRetain.timeIntervalSinceNow) > timeInterval
        }
    }
}

extension Observed where Input: Equatable {
    @discardableResult
    public func retainUntil(found: Input) -> Invokable {
        return retainUntil { changes in
            changes.new == found
        }
    }
}

extension Observed where Input: AnyObject {
    @discardableResult
    public func retainUntilObject(found: Input) -> Invokable {
        return retainUntil { changes in
            changes.new === found
        }
    }
}
