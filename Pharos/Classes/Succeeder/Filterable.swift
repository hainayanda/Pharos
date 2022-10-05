//
//  Filterable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

public protocol FilterableObservable: Invokable {
    associatedtype Output
    func filterChange(_ shouldInclude: @escaping (Changes<Output>) -> Bool) -> Observable<Output>
    func filter(_ shouldInclude: @escaping (Output) -> Bool) -> Observable<Output>
    func ignoreChange(_ shouldIgnore: @escaping (Changes<Output>) -> Bool) -> Observable<Output>
    func ignore(_ shouldIgnore: @escaping (Output) -> Bool) -> Observable<Output>
}

extension FilterableObservable where Self: ObservableProtocol, Self: ObjectRetainer {
    
    public func filterChange(_ shouldInclude: @escaping (Changes<Output>) -> Bool) -> Observable<Output> {
        succeeding(with: FilteredObservable(parent: self, shouldInclude))
    }
    
    @inlinable public func filter(_ shouldInclude: @escaping (Output) -> Bool) -> Observable<Output> {
        filterChange { changes in
            shouldInclude(changes.new)
        }
    }
    
    @available(*, deprecated, renamed: "filterChange")
    @inlinable public func onlyInclude(when shouldInclude: @escaping (Changes<Output>) -> Bool) -> Observable<Output> {
        filterChange(shouldInclude)
    }
    
    @inlinable public func ignoreChange(_ shouldIgnore: @escaping (Changes<Output>) -> Bool) -> Observable<Output> {
        filterChange { !shouldIgnore($0) }
    }
    
    @inlinable public func ignore(_ shouldIgnore: @escaping (Output) -> Bool) -> Observable<Output> {
        filter { !shouldIgnore($0) }
    }
}

extension FilterableObservable where Output: Equatable {
    @inlinable public func distinct() -> Observable<Output> {
        filterChange { $0.isChanging }
    }
    
    @available(*, deprecated, renamed: "distinct")
    @inlinable public func ignoreSameValue() -> Observable<Output> {
        distinct()
    }
}

extension Observable: FilterableObservable { }

final class FilteredObservable<Output>: SucceederObservable<Output, Output> {
    
    private lazy var _recentState: Output? = {
        guard let parentRecent = (parent as? Observable<Input>)?.recentState,
              filter(Changes(new: parentRecent))else {
            return nil
        }
        return parentRecent
    }()
    @inlinable override var recentState: Output? { _recentState }
    
    let filter: (Changes<Input>) -> Bool
    
    @inlinable init(parent: ObserverParent, _ filter: @escaping (Changes<Input>) -> Bool) {
        self.filter = filter
        super.init(parent: parent)
    }
    
    @inlinable override func accept(changes: Changes<Output>) {
        guard filter(changes) else { return }
        super.sendIfNeeded(for: changes)
        _recentState = changes.new
    }
}
