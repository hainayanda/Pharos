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
    
    public func mapped<Mapped>(_ mapper: @escaping (Output) -> Mapped) -> Observable<Mapped> {
        compactMapped(mapper)
    }
}

public protocol UnwrappableOptional {
    func unwrap() -> Self?
}

extension Optional: UnwrappableOptional {
    // swiftlint:disable:next syntactic_sugar
    public func unwrap() -> Optional<Wrapped>? {
        switch self {
        case .none:
            return nil
        case .some(let wrapped):
            return wrapped
        }
    }
}

extension MappableObservable where Output: UnwrappableOptional {
    public func compact() -> Observable<Output> {
        compactMapped { $0.unwrap() }
    }
}

extension Observable: MappableObservable { }

class MappedObservable<Input, Output>: SucceederObservable<Input, Output> {
    
    let mapper: (Input) -> Output?
    
    private lazy var _recentState: Output? = {
        guard let unMapped = (parent as? Observable<Input>)?.recentState else { return nil }
        return mapper(unMapped)
    }()
    override var recentState: Output? { _recentState }
    
    init(parent: ObserverParent, _ mapper: @escaping (Input) -> Output?) {
        self.mapper = mapper
        super.init(parent: parent)
    }
    
    override func accept(changes: Changes<Input>) {
        guard let mapped = tryMap(changes: changes) else { return }
        super.sendIfNeeded(for: mapped)
        _recentState = mapped.new
    }
    
    func tryMap(changes: Changes<Input>) -> Changes<Output>? {
        guard let newValue = mapper(changes.new) else {
            return nil
        }
        guard let old = recentState else {
            return Changes(new: newValue, old: nil)
        }
        return Changes(new: newValue, old: old)
    }
}
