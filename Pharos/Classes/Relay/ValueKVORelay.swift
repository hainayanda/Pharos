//
//  ValueKVORelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation

public extension ValueRelay {
    static func relay<Object: NSObject, Value>(
        of object: Object,
        _ keyPath: KeyPath<Object, Value>) -> ValueRelay<Value> {
        ValueKVORelay<Object, Value>(object, keyPath: keyPath)
    }
}

public class ValueKVORelay<Object: NSObject, Value>: ValueRelay<Value> {
    public typealias Observed = Value
    var token: Any?
    
    init(_ object: Object, keyPath: KeyPath<Object, Value>) {
        super.init(currentValue: object[keyPath: keyPath])
        self.token = observeChange(object: object, keyPath)
    }
    
    func observeChange<Object: NSObject, PathValue>(object: Object, _ keyPath: KeyPath<Object, PathValue>) -> NSObjectProtocol {
        object.observe(keyPath, options: [.new, .old]) { [weak self] object, kvoChanges in
            guard let self = self else { return }
            guard let old: Value = kvoChanges.oldValue as? Value,
                  let new = kvoChanges.newValue as? Value else {
                return
            }
            self.relay(changes: Changes(old: old, new: new, source: object))
        }
    }
}
