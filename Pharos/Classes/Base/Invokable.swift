//
//  Invokable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

public protocol Invokable: AnyObject {
    func fire()
}

protocol InvokeChainable: Invokable {
    func signalFire(from triggers: [ObjectIdentifier])
}

extension Invokable {
    @inlinable func fire(after delay: TimeInterval) {
        (DispatchQueue.current ?? DispatchQueue.main)
            .asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.fire()
            }
    }
}
