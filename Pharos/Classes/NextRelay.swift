//
//  NextRelay.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation

public class NextRelay<Value>: RelayOperationHandler, Hashable {
    
    var referenced: Bool = false
    weak var discardable: Discardable? {
        didSet {
            referenced = true
        }
    }
    
    var isValid: Bool { !isInvalid }
    
    var isInvalid: Bool { referenced && discardable?.discarded ?? true }
    
    var uniqueKey: String {
        let address = Int(bitPattern: Unmanaged.passUnretained(self).toOpaque())
        return NSString(format: "%p", address) as String
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueKey)
    }
    
    func relay(changes: Changes<Value>) {
        fatalError("should overridden")
    }
    
    func with(dereferencer: Dereferencer) -> Self {
        dereferencer.add(discardable: makeDiscardable())
        return self
    }
    
    public func discard() {
        referenced = true
        discardable?.discard()
    }
    
    public func makeDiscardable() -> Discardable {
        let discardable = self.discardable ?? Discardable(content: self)
        self.discardable = discardable
        return discardable
    }
    
    public func removeAllNextRelays() {
        fatalError("should overridden")
    }
    
    public static func == (lhs: NextRelay<Value>, rhs: NextRelay<Value>) -> Bool {
        lhs.uniqueKey == rhs.uniqueKey
    }
}
