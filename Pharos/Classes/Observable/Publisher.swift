//
//  Publisher.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

open class Publisher<Output>: BufferedObservable<Output> {
    
    public override init() {
        super.init()
    }
    
    public init(_ buffer: Output) {
        super.init()
        self.buffer = buffer
    }
    
    open func publish(_ value: Output) {
        send(changes: Changes(new: value, old: buffer))
        buffer = value
    }
}
