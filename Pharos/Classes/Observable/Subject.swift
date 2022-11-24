//
//  Subject.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

@propertyWrapper
public final class Subject<Wrapped>: BufferedObservable<Wrapped> {
    
    @inlinable public var projectedValue: Observable<Wrapped> { self }
    
    public var wrappedValue: Wrapped {
        get {
            buffer!
        }
        set {
            accept(Changes(new: newValue, old: buffer!))
        }
    }
    
    public init(wrappedValue: Wrapped) {
        super.init()
        self.buffer = wrappedValue
    }
}
