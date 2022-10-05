//
//  Dispatchable.swift
//  Pharos
//
//  Created by Nayanda Haberty on 5/10/22.
//

import Foundation
import Chary

public protocol DispatchableObservable: Invokable {
    associatedtype Output
    
    func dispatch(on queue: DispatchQueue, syncPrefered: Bool) -> Observable<Output>
}

extension DispatchableObservable where Self: ObservableProtocol, Self: ObserverParent {
    public func dispatch(on queue: DispatchQueue, syncPrefered: Bool = true) -> Observable<Output> {
        succeeding(with: DispatchedObservable(parent: self, queue: queue, preferSync: syncPrefered))
    }
    
    @inlinable public func dispatchOnMain(preferSync: Bool = true) -> Observable<Output> {
        dispatch(on: .main, syncPrefered: preferSync)
    }
    
    @inlinable public func dispatchInBackground() -> Observable<Output> {
        dispatch(on: .global(qos: .background), syncPrefered: false)
    }
}

extension Observable: DispatchableObservable { }

final class DispatchedObservable<Output>: SucceederObservable<Output, Output> {
    
    let preferSync: Bool
    let queue: DispatchQueue
    
    @inlinable init(parent: ObserverParent, queue: DispatchQueue, preferSync: Bool) {
        self.queue = queue
        self.preferSync = preferSync
        super.init(parent: parent)
    }
    
    @inlinable override func accept(changes: Changes<Output>) {
        let work = DispatchWorkItem { [weak self] in
            self?.sendIfNeeded(for: changes)
        }
        guard preferSync else {
            queue.async(execute: work)
            return
        }
        queue.asyncIfNeeded(execute: work)
    }
}
