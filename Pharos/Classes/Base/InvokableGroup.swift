//
//  InvokableGroup.swift
//  Pharos
//
//  Created by Nayanda Haberty on 24/11/22.
//

import Foundation

class InvokableGroup: Invokable {
    
    let invokables: [Invokable]
    
    init(invokables: [Invokable]) {
        self.invokables = invokables
    }
    
    @inlinable func fire() {
        invokables.first?.fire()
    }
}
