//
//  ObservableProtocol.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

public protocol AnyObservable {
    func typeErasedObservable() -> Observable<Any>
}

extension AnyObservable where Self: MappableObservable {
    @inlinable public func typeErasedObservable() -> Observable<Any> {
        mapped { $0 }
    }
}

public protocol ObservableProtocol: AnyObservable {
    associatedtype Output
    func observeChange(_ observer: @escaping (Changes<Output>) -> Void) -> Observed<Output>
    func observe(_ observer: @escaping (Output) -> Void) -> Observed<Output>
}

public extension ObservableProtocol {
    @available(*, deprecated, renamed: "observeChange")
    @inlinable func whenDidSet(thenDo work: @escaping (Changes<Output>) -> Void) -> Observed<Output> {
        observeChange(work)
    }
    
    @inlinable func observe(_ observer: @escaping (Output) -> Void) -> Observed<Output> {
        observeChange { changes in
            observer(changes.new)
        }
    }
}

extension ObservableProtocol {
    func succeeding<Succeeder: Observing>(with succeeder: Succeeder) -> Succeeder where Succeeder.Input == Self.Output {
        observeChange { changes in
            succeeder.accept(changes: changes)
        }.retain()
        return succeeder
    }
}

protocol Observing: AnyObject {
    associatedtype Input
    func accept(changes: Changes<Input>)
}
