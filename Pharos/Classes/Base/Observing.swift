//
//  Observing.swift
//  Pharos
//
//  Created by Nayanda on 16/11/22.
//

import Foundation

// MARK: Observing

protocol Observing {
    associatedtype Input
    
    @discardableResult
    func accept(_ changes: Changes<Input>) -> Bool
}
