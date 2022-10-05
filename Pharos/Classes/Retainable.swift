//
//  Retainable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

public protocol Retainable: AnyObject {
    @discardableResult
    func retained(by object: AnyObject) -> Invokable
    @discardableResult
    func retain() -> Invokable
}
