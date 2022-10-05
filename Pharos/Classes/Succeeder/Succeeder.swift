//
//  Succeeder.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

open class SucceederObservable<Input, Output>: Observable<Output>, ObservingObservable {
    weak var parent: ObserverParent?
    
    public override var recentState: Output? {
        (parent as? Observable<Output>)?.recentState
    }
    
    public init(parent: ObserverParent) {
        self.parent = parent
    }
    
    @inlinable open func accept(changes: Changes<Input>) { }
    
    open override func fire() {
        parent?.fire()
    }
}
