//
//  Changes.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public struct Changes<State> {
    public let new: State
    public private(set) var old: State?
    private var consumers: [ObjectIdentifier] = []
    
    init(new: State, old: State? = nil) {
        self.new = new
        self.old = old
    }
    
    func alreadyConsumed(by source: AnyObject) -> Bool {
        consumers.contains(ObjectIdentifier(source))
    }
    
    func consumed(by source: AnyObject) -> Changes {
        var mutableSelf = self
        mutableSelf.consumers.append(ObjectIdentifier(source))
        return mutableSelf
    }
    
    func withNoOld() -> Changes {
        var mutableSelf = self
        mutableSelf.old = nil
        return mutableSelf
    }
    
    func with(old: State?) -> Changes {
        var mutableSelf = self
        mutableSelf.old = old
        return mutableSelf
    }
}

extension Changes: Equatable where State: Equatable {
    public var isChanging: Bool { new == old }
    public var isNotChanging: Bool { !isChanging }
    
    public static func == (lhs: Changes<State>, rhs: Changes<State>) -> Bool {
        lhs.new == rhs.new && lhs.old == rhs.old
    }
}

extension Changes: Hashable where State: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(new)
        hasher.combine(old)
    }
}

public extension Changes where State: AnyObject {
    var isSameInstance: Bool { new === old }
    var isNewInstance: Bool { !isSameInstance }
}
