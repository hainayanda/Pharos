//
//  WeakWrappedObserver.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

final class WeakWrappedObserver<Input>: Observing {
    
    weak var wrapped: Observed<Input>?
    @inlinable var valid: Bool { wrapped != nil }
    
    @inlinable init(wrapped: Observed<Input>) {
        self.wrapped = wrapped
    }
    
    @inlinable func accept(changes: Changes<Input>) {
        wrapped?.accept(changes: changes)
    }
}
