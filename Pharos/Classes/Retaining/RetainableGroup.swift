//
//  RetainableGroup.swift
//  Pharos
//
//  Created by Nayanda Haberty on 24/11/22.
//

import Foundation

class RetainableGroup: Retainable {
    
    var retainables: [Retainable]
    
    init(retainables: [Retainable]) {
        self.retainables = retainables
    }
    
    func asParent<Child>(of observable: Child) -> Child where Child: AnyObservable {
        retained(by: observable)
        return observable
    }
    
    @discardableResult
    @inlinable func retained(by object: AnyObject) -> Invokable {
        InvokableGroup(invokables: retainables.map { $0.retained(by: object) })
    }
    
    @discardableResult
    @inlinable func retainedExclusively(by object: AnyObject) -> Invokable {
        InvokableGroup(invokables: retainables.map { $0.retainedExclusively(by: object) })
    }
    
    @discardableResult
    @inlinable func retain() -> Invokable {
        InvokableGroup(invokables: retainables.map { $0.retain() })
    }
    
    @discardableResult
    @inlinable func retainUntil(_ shouldDiscard: @escaping () -> Bool) -> Invokable {
        InvokableGroup(invokables: retainables.map { $0.retainUntil(shouldDiscard) })
    }
    
    @inlinable func discard() {
        retainables.forEach { $0.discard() }
        retainables = []
    }
    
}
