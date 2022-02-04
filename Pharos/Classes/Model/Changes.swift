//
//  Changes.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public struct Changes<Value> {
    public let old: Value?
    public let new: Value
    public let source: AnyObject
    
    init(old: Value?, new: Value, source: AnyObject) {
        self.old = old
        self.new = new
        self.source = source
    }
    
    func map<NewValue>(_ mapper: (Value) throws -> NewValue?) -> Changes<NewValue>? {
        guard let mappedNew: NewValue = try? mapper(new) else {
            return nil
        }
        let mappedOld: NewValue?
        if let old = old {
            mappedOld = try? mapper(old)
        } else {
            mappedOld = nil
        }
        return .init(
            old: mappedOld,
            new: mappedNew,
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
        lhs.new == rhs.new && lhs.old == rhs.old && lhs.source === rhs.source
    }
}
