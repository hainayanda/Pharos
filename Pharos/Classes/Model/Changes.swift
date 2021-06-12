//
//  Changes.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public struct Changes<Value> {
    public let old: Value
    public let new: Value
    public let source: Any
    
    init(old: Value, new: Value, source: Any) {
        self.old = old
        self.new = new
        self.source = source
    }
    
    func map<NewValue>(_ mapper: (Value) -> NewValue) -> Changes<NewValue> {
        .init(
            old: mapper(old),
            new:  mapper(new),
            source: source
        )
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
