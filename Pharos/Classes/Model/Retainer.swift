//
//  Retainer.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

@available(*, renamed: "Dereferencer")
public final class Retainer {
    var discardables: [Discardable] = []
    
    public init() { }
    
    func add(discardable: Discardable) {
        guard !discardable.isValid else { return }
        discardable.retained()
        discardables.append(discardable)
    }
    
    public func discardAll() {
        discardables.forEach {
            $0.unretained()
        }
        discardables = []
    }
    
    deinit {
        discardAll()
    }
}

public protocol Discardable {
    var retainerCount: Int { get }
    var isValid: Bool { get }
    func discard()
    func retained()
    func unretained()
}

extension Discardable {
    var isInValid: Bool { !isValid }
}
