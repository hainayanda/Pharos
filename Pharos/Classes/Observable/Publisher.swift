//
//  Publisher.swift
//  Pharos
//
//  Created by Nayanda Haberty on 03/02/22.
//

import Foundation

open class Publisher<Output>: Observable<Output> {
    
    private var _recentState: Output?
    public override var recentState: Output? { _recentState }
    
    public override init() {
        super.init()
    }
    
    open func publish(_ value: Output) {
        defer { _recentState = value }
        send(changes: Changes(new: value, old: recentState))
    }
}
