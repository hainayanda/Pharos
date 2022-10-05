//
//  MergedObservable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation

final class MergedObservable<Output>: Observable<Output> {
    
    private var _recentState: Output?
    @inlinable override var recentState: Output? { _recentState }
    
    @inlinable init(merged: [Observable<Output>]) {
        super.init()
        merged.forEach {
            $0.relayChanges(to: self).retain()
            $0.retain(self)
        }
    }
    
    @inlinable override func send(changes: Changes<Output>) {
        super.send(changes: changes.with(old: recentState ?? changes.old))
        _recentState = changes.new
    }
}

extension Observable {
    @inlinable public func merged(with others: Observable<Output>...) -> Observable<Output> {
        merged(with: others)
    }
    
    public func merged(with others: [Observable<Output>]) -> Observable<Output> {
        guard !others.isEmpty else { return self }
        var merged = others
        merged.append(self)
        return MergedObservable(merged: merged)
    }
    
    @available(*, deprecated, renamed: "merged")
    @inlinable public func merge(with others: Observable<Output>...) -> Observable<Output> {
        merged(with: others)
    }
}
