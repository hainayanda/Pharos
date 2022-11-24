//
//  CombinedObservable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

extension Observable {
    public func combine<Output2>(with other: Observable<Output2>) -> Observable<(Output?, Output2?)> {
        let child = CombinedObservable(parent1: self, parent2: other)
        var recentValue: Changes<(Output?, Output2?)>?
        if let buffered = self as? BufferedObservable<Output>, let buffer = buffered.buffer {
            recentValue = Changes(new: (buffer, nil))
        }
        if let buffered = other as? BufferedObservable<Output2>, let buffer = buffered.buffer {
            recentValue = Changes(new: (recentValue?.new.0, buffer))
        }
        
        observeChange { [unowned child] value in
            let combinedValue: Changes<(Output?, Output2?)> = Changes(
                new: (value.new, recentValue?.new.1),
                old: (value.old, recentValue?.new.1),
                triggers: value.triggers,
                consumers: value.consumers
            ).consumed(by: child)
            child.send(changes: combinedValue)
            recentValue = combinedValue
        }.retained(by: child)
        
        other.observeChange { [unowned child] value in
            let combinedValue: Changes<(Output?, Output2?)> = Changes(
                new: (recentValue?.new.0, value.new),
                old: (recentValue?.new.0, value.old),
                triggers: value.triggers,
                consumers: value.consumers
            ).consumed(by: child)
            child.send(changes: combinedValue)
            recentValue = combinedValue
        }.retained(by: child)
        
        return child
    }
    
    @inlinable public func compactCombine<Output2>(with other: Observable<Output2>) -> Observable<(Output, Output2)> {
        combine(with: other).compactMapped { tuple in
            guard let value1 = tuple.0, let value2 = tuple.1 else { return nil }
            return (value1, value2)
        }
    }
    
    @inlinable public func combine<Output2, Output3>(
        with other1: Observable<Output2>, _ other2: Observable<Output3>) -> Observable<(Output?, Output2?, Output3?)> {
            combine(with: other1)
                .combine(with: other2)
                .mapped { tuple in
                    (tuple.0?.0, tuple.0?.1, tuple.1)
                }
        }
    
    @inlinable public func compactCombine<Output2, Output3>(
        with other1: Observable<Output2>, _ other2: Observable<Output3>) -> Observable<(Output, Output2, Output3)> {
            combine(with: other1, other2).compactMapped { tuple in
                guard let value1 = tuple.0, let value2 = tuple.1, let value3 = tuple.2 else { return nil }
                return (value1, value2, value3)
            }
        }
    
    @inlinable public func combine<Output2, Output3, Output4>(
        with other1: Observable<Output2>, _ other2: Observable<Output3>, _ other3: Observable<Output4>)
    -> Observable<(Output?, Output2?, Output3?, Output4?)> {
        combine(with: other1)
            .combine(with: other2)
            .combine(with: other3)
            .mapped { tuple in
                (tuple.0?.0?.0, tuple.0?.0?.1, tuple.0?.1, tuple.1)
            }
    }
    
    public func compactCombine<Output2, Output3, Output4>(
        with other1: Observable<Output2>, _ other2: Observable<Output3>, _ other3: Observable<Output4>)
    -> Observable<(Output, Output2, Output3, Output4)> {
        combine(with: other1, other2, other3).compactMapped { tuple in
            guard let value1 = tuple.0, let value2 = tuple.1, let value3 = tuple.2, let value4 = tuple.3 else { return nil }
            return (value1, value2, value3, value4)
        }
    }
}

class CombinedObservable<Value1, Output2>: BufferedObservable<(Value1?, Output2?)> {
    private weak var parent1: Observable<Value1>?
    private weak var parent2: Observable<Output2>?
    
    // this is not ancestor, but will be a source of autoRetain for next observer and its child
    @inlinable var source: AnyObservable? { self }
    
    override var parent: AnyObservable? {
        parent1 ?? parent2
    }
    var ancestor: AnyObservable? {
        parent1?.ancestor ?? parent2?.ancestor
    }
    
    init(parent1: Observable<Value1>, parent2: Observable<Output2>) {
        self.parent1 = parent1
        self.parent2 = parent2
        super.init(isAncestor: false)
    }
    
    override func fire() {
        guard buffer?.0 as? Value1 == nil || buffer?.1 as? Output2 == nil else {
            super.fire()
            return
        }
        let trigger = [ObjectIdentifier(self)]
        parent1?.signalFire(from: trigger)
        parent2?.signalFire(from: trigger)
    }
    
    override func signalFire(from triggers: [ObjectIdentifier]) {
        guard buffer?.0 as? Value1 == nil || buffer?.1 as? Output2 == nil else {
            super.signalFire(from: triggers)
            return
        }
        var triggers = triggers
        triggers.append(ObjectIdentifier(self))
        parent1?.signalFire(from: triggers)
        parent2?.signalFire(from: triggers)
    }
}
