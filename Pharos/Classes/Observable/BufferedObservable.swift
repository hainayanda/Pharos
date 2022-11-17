//
//  BufferedObservable.swift
//  Pharos
//
//  Created by Nayanda on 17/11/22.
//

import Foundation

open class BufferedObservable<Output>: Observable<Output> {
    public var buffer: Output?
    
    @discardableResult
    override func accept(_ changes: Changes<Output>) -> Bool {
        guard super.accept(changes) else { return false }
        buffer = changes.new
        return true
    }
    
    public override func fire() {
        guard let buffer = buffer else { return }
        accept(Changes(new: buffer))
    }
    
    override func signalFire(from triggers: [ObjectIdentifier]) {
        guard let buffer = buffer else { return }
        var triggers = triggers
        triggers.append(ObjectIdentifier(self))
        accept(Changes(new: buffer, triggers: triggers))
    }
}
