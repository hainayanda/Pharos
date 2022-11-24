//
//  Changes.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public struct Changes<State> {
    public let new: State
    public internal(set) var old: State?
    var consumers: [ObjectIdentifier] = []
    let triggers: [ObjectIdentifier]?
    
    public init(new: State, old: State? = nil, triggers: [ObjectIdentifier]? = nil, consumers: [ObjectIdentifier] = []) {
        self.triggers = triggers
        self.new = new
        self.old = old
        self.consumers = consumers
    }
    
    func canBeConsumed(by source: AnyObject) -> Bool {
        guard !alreadyConsumed(by: source) else { return false }
        guard let triggers = triggers else { return true }
        let realSource = (source as? WrappingObserver)?.wrapped ?? source
        guard triggers.contains(ObjectIdentifier(realSource)) else {
            guard let parent = (realSource as? AnyObservable)?.parent else { return false }
            return triggers.contains(ObjectIdentifier(parent))
        }
        return true
    }
    
    func alreadyConsumed(by source: AnyObject) -> Bool {
        consumers.contains(ObjectIdentifier(source))
    }
    
    func consumed(by source: AnyObject) -> Changes {
        var mutableSelf = self
        mutableSelf.consumers.append(ObjectIdentifier(source))
        return mutableSelf
    }
    
    func with(old: State?) -> Changes {
        var mutableSelf = self
        mutableSelf.old = old
        return mutableSelf
    }
    
    func mapped<NewState>(_ mapper: (State) -> NewState) -> Changes<NewState> {
        var newChanges = Changes<NewState>(new: mapper(new))
        newChanges.consumers = consumers
        guard let old = self.old else { return newChanges }
        return newChanges.with(old: mapper(old))
    }
    
    func compactMapped<NewState>(_ mapper: (State) -> NewState?) -> Changes<NewState>? {
        guard let newMapped = mapper(new) else { return nil }
        var newChanges = Changes<NewState>(new: newMapped)
        newChanges.consumers = consumers
        guard let old = self.old else { return newChanges }
        return newChanges.with(old: mapper(old))
    }
}

extension Changes: Equatable where State: Equatable {
    @inlinable public var isChanging: Bool { !isNotChanging }
    @inlinable public var isNotChanging: Bool { new == old }
    
    @inlinable public static func == (lhs: Changes<State>, rhs: Changes<State>) -> Bool {
        lhs.new == rhs.new && lhs.old == rhs.old
    }
}

extension Changes: Hashable where State: Hashable {
    @inlinable public func hash(into hasher: inout Hasher) {
        hasher.combine(new)
        hasher.combine(old)
    }
}

extension Changes where State: AnyObject {
    @inlinable public var isSameInstance: Bool { new === old }
    @inlinable public var isNewInstance: Bool { !isSameInstance }
}
