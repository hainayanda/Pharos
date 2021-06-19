//
//  BearerKVORelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 19/06/21.
//

import Foundation

public extension BearerRelay {
    static func relay<Object: NSObject, Value>(
        of object: Object,
        _ keyPath: ReferenceWritableKeyPath<Object, Value>) -> AssociativeBearerRelay<Value> {
        BearerKVORelay<Object, Value>(object, keyPath: keyPath)
    }
}

public class BearerKVORelay<Object: NSObject, Value>: AssociativeBearerRelay<Value> {
    public typealias Observed = Value
    
    var keyPath: ReferenceWritableKeyPath<Object, Value>
    
    init(_ object: Object, keyPath: ReferenceWritableKeyPath<Object, Value>) {
        self.keyPath = keyPath
        super.init(object, currentValue: object[keyPath: keyPath]) { [weak object] changes in
            guard let object = object else { return }
            object[keyPath: keyPath] = changes.new
        }
    }
    
    public override func relay(changes: Changes<Value>) -> Bool {
        super.relay(changes: changes)
    }
}
