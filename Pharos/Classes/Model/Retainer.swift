//
//  Retainer.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

@available(*, renamed: "Dereferencer")
public class Retainer {
    var discardables: [Discardable] = []
    
    public init() { }
    
    func add(discardable: Discardable) {
        guard !discardable.isValid else { return }
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

public protocol Discardable {
    var isValid: Bool { get }
    func discard()
}

extension Discardable {
    var isInValid: Bool { !isValid }
}
