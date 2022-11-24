//
//  MergedObservable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

extension Observable {
    /// Merge multiple Observable so it could be bind as one
    /// - Parameter others: Other Observable to be merged
    /// - Returns: Observable
    public func merged(with others: Observable<Output>...) -> Observable<Output> {
        var merged = others
        merged.append(self)
        let child = MergedObservable(parents: merged)
        merged.forEach { bindable in
            bindable.observeChange { [unowned child] value in
                child.accept(value)
            }.retained(by: child)
        }
        return child
    }
}

class MergedObservable<Value>: BufferedObservable<Value> {
    
    private var weakParents: [WeakBindableWrapper]
    var parents: [InvokableObservable] {
        weakParents.compactMap { $0.bindable }
    }
    
    // this is not ancestor, but will be a source of autoRetain for next observer and its child
    var source: AnyObservable? { self }
    
    override var parent: AnyObservable? {
        weakParents.lazy.compactMap { $0.bindable }.first
    }
    var ancestor: AnyObservable? {
        weakParents.lazy.compactMap { $0.bindable?.ancestor }.first
    }
    
    init(parents: [Observable<Value>]) {
        self.weakParents = parents.compactMap { WeakBindableWrapper(bindable: $0) }
        super.init(isAncestor: false)
    }
    
    @discardableResult
    override func accept(_ changes: Changes<Value>) -> Bool {
        super.accept(changes.with(old: buffer ?? changes.old))
    }
    
    override func fire() {
        guard buffer == nil else {
            super.fire()
            return
        }
        parents.first?.signalFire(from: [ObjectIdentifier(self)])
    }
    
    override func signalFire(from triggers: [ObjectIdentifier]) {
        guard  buffer == nil else {
            super.signalFire(from: triggers)
            return
        }
        var triggers = triggers
        triggers.append(ObjectIdentifier(self))
        parents.first?.signalFire(from: triggers)
    }
}

struct WeakBindableWrapper {
    weak var bindable: InvokableObservable?
}
