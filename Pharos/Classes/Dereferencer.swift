//
//  Dereferencer.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public class Dereferencer {
    var discardables: [Discardable] = []
    
    public init() { }
    
    func add(discardable: Discardable) {
        guard !discardable.discarded else { return }
        discardables.append(discardable)
    }
    
    public func discardAll() {
        discardables.forEach { $0.discard() }
        discardables = []
    }
    
    deinit {
        discardAll()
    }
}

public class Discardable {
    public internal(set) var discarded: Bool = false
    var content: Any?
    
    init(content: Any) {
        self.content = content
    }
    
    public func discard() {
        content = nil
        discarded = true
    }
}
