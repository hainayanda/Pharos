//
//  BearerKVORelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 19/06/21.
//

import Foundation

extension BearerRelay {
    static func relay<Object: NSObject, Value>(
        of object: Object,
        _ keyPath: ReferenceWritableKeyPath<Object, Value>) -> AssociativeBearerRelay<Value> {
        BearerKVORelay<Object, Value>(object, keyPath: keyPath)
    }
}

final class BearerKVORelay<Object: NSObject, Value>: AssociativeBearerRelay<Value> {
    typealias Observed = Value
    
    var keyPath: ReferenceWritableKeyPath<Object, Value>
    
    init(_ object: Object, keyPath: ReferenceWritableKeyPath<Object, Value>) {
        self.keyPath = keyPath
        super.init(object, currentValue: object[keyPath: keyPath]) { [weak object] changes in
            guard let object = object else { return }
            object[keyPath: keyPath] = changes.new
        }
    }
    
    override func relay(changes: Changes<Value>) -> Bool {
        super.relay(changes: changes)
    }
}
