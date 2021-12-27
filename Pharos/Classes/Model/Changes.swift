//
//  Changes.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public struct Changes<Value> {
    public let invokedManually: Bool
    public let old: Value
    public let new: Value
    public let source: Any
    
    init(old: Value, new: Value, invokedManually: Bool = false, source: Any) {
        self.old = old
        self.new = new
        self.invokedManually = invokedManually
        self.source = source
    }
    
    func map<NewValue>(_ mapper: (Value) throws -> NewValue?) -> Changes<NewValue>? {
        guard let mappedOld: NewValue = try? mapper(old),
              let mappedNew: NewValue = try? mapper(new) else { return nil }
        return Changes<NewValue>(
            old: mappedOld,
            new:  mappedNew,
            source: source
        )
    }
}

extension Changes where Value: AnyObject {
    public var isSameInstance: Bool {
        old === new
    }
    
    public var isChangingWithNewInstance: Bool {
        !isSameInstance
    }
}

extension Changes: Equatable where Value: Equatable {
    public var isNotChanging: Bool {
        old == new
    }
    public var isChanging: Bool {
        !isNotChanging
    }
    public static func == (lhs: Changes<Value>, rhs: Changes<Value>) -> Bool {
        lhs.new == rhs.new && lhs.old == rhs.old
    }
}
