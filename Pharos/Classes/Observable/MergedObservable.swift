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
        var buffer: Output?
        var merged = others
        merged.append(self)
        let child = MergedBindable(parents: merged)
        merged.forEach { bindable in
            bindable.observeChange { [unowned child] value in
                child.accept(value.with(old: buffer ?? value.old))
                buffer = value.new
            }.retained(by: child)
        }
        return child
    }
}

class MergedBindable<Value>: Observable<Value> {
    
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
    
    override func fire() {
        parents.forEach { $0.signalFire(from: [ObjectIdentifier(self)])}
    }
    
    override func signalFire(from triggers: [ObjectIdentifier]) {
        var triggers = triggers
        triggers.append(ObjectIdentifier(self))
        parents.forEach { $0.signalFire(from: triggers)}
    }
}

struct WeakBindableWrapper {
    weak var bindable: InvokableObservable?
}
