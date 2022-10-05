//
//  ObserverParentTemporaryRetainer.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

public typealias ObserverParent = Invokable & ObjectRetainer

final class ObserverParentTemporaryRetainer {
    private weak var weakInstance: ObserverParent?
    private var _instance: ObserverParent?
    @inlinable var instance: ObserverParent? { weakInstance }
    @inlinable var retaining: Bool { _instance != nil }
    
    @inlinable init(instance: ObserverParent?) {
        self._instance = instance
        self.weakInstance = instance
    }
    
    @inlinable func releaseParent() {
        _instance = nil
    }
}
