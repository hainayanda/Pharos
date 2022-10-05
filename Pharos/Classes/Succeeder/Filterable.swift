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

extension FilterableObservable where Self: ObservableProtocol, Self: ObserverParent {
    
    public func filterChange(_ shouldInclude: @escaping (Changes<Output>) -> Bool) -> Observable<Output> {
        succeeding(with: FilteredObservable(parent: self, shouldInclude))
    }
    
    public func filter(_ shouldInclude: @escaping (Output) -> Bool) -> Observable<Output> {
        filterChange { changes in
            shouldInclude(changes.new)
        }
    }
    
    @available(*, deprecated, renamed: "filterChange")
    public func onlyInclude(when shouldInclude: @escaping (Changes<Output>) -> Bool) -> Observable<Output> {
        filterChange(shouldInclude)
    }
    
    public func ignoreChange(_ shouldIgnore: @escaping (Changes<Output>) -> Bool) -> Observable<Output> {
        filterChange { !shouldIgnore($0) }
    }
    
    public func ignore(_ shouldIgnore: @escaping (Output) -> Bool) -> Observable<Output> {
        filter { !shouldIgnore($0) }
    }
}

extension FilterableObservable where Output: Equatable {
    public func distinct() -> Observable<Output> {
        filterChange { $0.isChanging }
    }
}

extension Observable: FilterableObservable { }

class FilteredObservable<Output>: SucceederObservable<Output, Output> {
    
    private lazy var _recentState: Output? = {
        guard let parentRecent = (parent as? Observable<Input>)?.recentState,
              filter(Changes(new: parentRecent))else {
            return nil
        }
        return parentRecent
    }()
    override var recentState: Output? { _recentState }
    
    let filter: (Changes<Input>) -> Bool
    
    init(parent: ObserverParent, _ filter: @escaping (Changes<Input>) -> Bool) {
        self.filter = filter
        super.init(parent: parent)
    }
    
    override func accept(changes: Changes<Output>) {
        guard filter(changes) else { return }
        super.sendIfNeeded(for: changes)
        _recentState = changes.new
    }
}
