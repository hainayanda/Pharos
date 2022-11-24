//
//  ExclusiveRetainableWrapper.swift
//  Pharos
//
//  Created by Nayanda Haberty on 24/11/22.
//

import Foundation

class ExclusiveRetainableWrapper {
    var retained: Retainable
    let source: ObjectIdentifier
    
    init(retained: Retainable, source: AnyObject) {
        self.retained = retained
        self.source = ObjectIdentifier(source)
    }
    
    @inlinable func isComing(from source: AnyObject) -> Bool {
        ObjectIdentifier(source) == self.source
    }
}
