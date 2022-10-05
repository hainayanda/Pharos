//
//  Mappable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

public protocol MappableObservable: Invokable {
    associatedtype Output
    
    func mapped<Mapped>(_ mapper: @escaping (Output) -> Mapped) -> Observable<Mapped>
    func compactMapped<Mapped>(_ mapper: @escaping (Output) -> Mapped?) -> Observable<Mapped>
}

extension MappableObservable where Self: ObservableProtocol, Self: ObserverParent {
    
    public func compactMapped<Mapped>(_ mapper: @escaping (Output) -> Mapped?) -> Observable<Mapped> {
        succeeding(with: MappedObservable<Output, Mapped>(parent: self, mapper))
    }
    
    @inlinable public func mapped<Mapped>(_ mapper: @escaping (Output) -> Mapped) -> Observable<Mapped> {
        compactMapped(mapper)
    }
}

public protocol UnwrappableOptional {
    func unwrap() -> Self?
}

extension Optional: UnwrappableOptional {
    // swiftlint:disable:next syntactic_sugar
    @inlinable public func unwrap() -> Optional<Wrapped>? {
        switch self {
        case .none:
            return nil
        case .some(let wrapped):
            return wrapped
        }
    }
}

extension MappableObservable where Output: UnwrappableOptional {
    @inlinable public func compacted() -> Observable<Output> {
        compactMapped { $0.unwrap() }
    }
}

extension Observable: MappableObservable { }

final class MappedObservable<Input, Output>: SucceederObservable<Input, Output> {
    
    let mapper: (Input) -> Output?
    
    private lazy var _recentState: Output? = {
        guard let unMapped = (parent as? Observable<Input>)?.recentState else { return nil }
        return mapper(unMapped)
    }()
    @inlinable override var recentState: Output? { _recentState }
    
    @inlinable init(parent: ObserverParent, _ mapper: @escaping (Input) -> Output?) {
        self.mapper = mapper
        super.init(parent: parent)
    }
    
    @inlinable override func accept(changes: Changes<Input>) {
        guard let mapped = tryMap(changes: changes) else { return }
        super.sendIfNeeded(for: mapped)
        _recentState = mapped.new
    }
    
    @inlinable func tryMap(changes: Changes<Input>) -> Changes<Output>? {
        guard let newValue = mapper(changes.new) else {
            return nil
        }
        guard let old = recentState else {
            return Changes(new: newValue, old: nil)
        }
        return Changes(new: newValue, old: old)
    }
}
