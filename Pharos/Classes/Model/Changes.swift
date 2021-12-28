//
//  Changes.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public struct Changes<Value> {
    public let invokedManually: Bool
    public let old: RelayValue<Value>
    public let new: Value
    public let source: Any
    
    init(old: Value, new: Value, invokedManually: Bool = false, source: Any) {
        self.old = .value(old)
        self.new = new
        self.invokedManually = invokedManually
        self.source = source
    }
    
    init(old: RelayValue<Value>, new: Value, invokedManually: Bool = false, source: Any) {
        self.old = old
        self.new = new
        self.invokedManually = invokedManually
        self.source = source
    }
    
    func map<NewValue>(_ mapper: (Value) throws -> NewValue?) -> Changes<NewValue>? {
        guard let mappedNew: NewValue = try? mapper(new) else { return nil }
        let mappedOld = old.map(mapper)
        return .init(
            old: mappedOld,
            new: mappedNew,
            invokedManually: invokedManually,
            source: source
        )
    }
}

public enum RelayValue<Value> {
    case value(Value)
    case none
    case error(Error)
    
    public var value: Value? {
        switch self {
        case .value(let value):
            return value
        default:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
    
    public var isNone: Bool {
        switch self {
        case .none:
            return true
        default:
            return false
        }
    }
    
    func map<NewValue>(_ mapper: (Value) throws -> NewValue?) -> RelayValue<NewValue> {
        switch self {
        case .none:
            return .none
        case .error(let error):
            return .error(error)
        case .value(let value):
            do {
                guard let mapped = try mapper(value) else {
                    return .none
                }
                return .value(mapped)
            } catch {
                return .error(PharosMapError(beforeMapped: value, error: error))
            }
        }
    }
}

extension RelayValue {
    func combine<Other>(with otherValue: RelayValue<Other>) -> RelayValue<(Value, Other)> {
        switch self {
        case .value(let value):
            guard let other = otherValue.value else {
                return .error(PharosBiMergeIncompleteError(self, otherValue))
            }
            return .value((value, other))
        default:
            return .error(PharosBiMergeIncompleteError(self, otherValue))
        }
    }
}

extension RelayValue {
    func combine<Other1, Other2>(with otherValue1: RelayValue<Other1>, _ otherValue2: RelayValue<Other2>) -> RelayValue<(Value, Other1, Other2)> {
        switch self {
        case .value(let value):
            guard let other1 = otherValue1.value, let other2 = otherValue2.value else {
                return .error(PharosTriMergeIncompleteError(self, otherValue1, otherValue2))
            }
            return .value((value, other1, other2))
        default:
            return .error(PharosTriMergeIncompleteError(self, otherValue1, otherValue2))
        }
    }
}

extension RelayValue {
    func combine<Other1, Other2, Other3>(with otherValue1: RelayValue<Other1>, _ otherValue2: RelayValue<Other2>, _ otherValue3: RelayValue<Other3>) -> RelayValue<(Value, Other1, Other2, Other3)> {
        switch self {
        case .value(let value):
            guard let other1 = otherValue1.value, let other2 = otherValue2.value, let other3 = otherValue3.value else {
                return .error(PharosQuadMergeIncompleteError(self, otherValue1, otherValue2, otherValue3))
            }
            return .value((value, other1, other2, other3))
        default:
            return .error(PharosQuadMergeIncompleteError(self, otherValue1, otherValue2, otherValue3))
        }
    }
}

extension Changes where Value: AnyObject {
    public var isSameInstance: Bool {
        old.value === new
    }
    
    public var isChangingWithNewInstance: Bool {
        !isSameInstance
    }
}

extension RelayValue: Equatable where Value: Equatable {
    public static func == (lhs: RelayValue<Value>, rhs: RelayValue<Value>) -> Bool {
        switch lhs {
        case .value(let value):
            return value == rhs.value
        case .none:
            return rhs.isNone
        case .error(let error):
            return rhs.error?.localizedDescription == error.localizedDescription
        }
    }
}

extension Changes: Equatable where Value: Equatable {
    public var isNotChanging: Bool {
        old.value == new
    }
    public var isChanging: Bool {
        !isNotChanging
    }
    public static func == (lhs: Changes<Value>, rhs: Changes<Value>) -> Bool {
        lhs.new == rhs.new && lhs.old == rhs.old
    }
}
