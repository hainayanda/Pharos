//
//  WeakWrappedObserver.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

class WeakWrappedObserver<Input>: Observing {
    
    weak var wrapped: Observed<Input>?
    var valid: Bool { wrapped != nil }
    
    init(wrapped: Observed<Input>) {
        self.wrapped = wrapped
    }
    
    func accept(changes: Changes<Input>) {
        wrapped?.accept(changes: changes)
    }
}
