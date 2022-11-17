//
//  Publisher.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

open class Publisher<Output>: BufferedObservable<Output> {
    
    public init() {
        super.init()
    }
    
    open func publish(_ value: Output) {
        send(changes: Changes(new: value, old: buffer))
        buffer = value
    }
}
