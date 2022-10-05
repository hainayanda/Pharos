//
//  ObserverParentTemporaryRetainer.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

public typealias ObserverParent = Invokable & ObjectRetainer

class ObserverParentTemporaryRetainer {
    private weak var weakInstance: ObserverParent?
    private var _instance: ObserverParent?
    var instance: ObserverParent? { weakInstance }
    var retaining: Bool { _instance != nil }
    
    init(instance: ObserverParent?) {
        self._instance = instance
        self.weakInstance = instance
    }
    
    func releaseParent() {
        _instance = nil
    }
}
