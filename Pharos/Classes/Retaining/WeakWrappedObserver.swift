//
//  WeakWrappedObserver.swift
//  Pharos
//
//  Created by Nayanda Haberty on 24/11/22.
//

import Foundation

struct WeakWrappedObserver<Value>: Observing {
    var valid: Bool { observer != nil }
    weak var observer: RetainableObserver<Value>?
    
    init(observer: RetainableObserver<Value>) {
        self.observer = observer
    }
    
    @discardableResult
    func accept(_ changes: Changes<Value>) -> Bool {
        observer?.accept(changes) ?? false
    }
}
