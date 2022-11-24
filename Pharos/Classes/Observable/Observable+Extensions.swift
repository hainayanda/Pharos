//
//  Observable+Extensions.swift
//  Pharos
//
//  Created by Nayanda on 16/11/22.
//

import Foundation
import Chary

// MARK: Observable + Child

extension Observable {
    
    /// Listen this Observable while creating a new Observable that consume value coming from this Observable
    /// - Parameter observer: Closure that takes value from this bindable and the new Observable that will consume the value
    /// - Returns: New Observable that consume the value from this bindable
    func addChildObservable<ChildOutput>(_ listener: @escaping (Changes<Output>, Observable<ChildOutput>) -> Void) -> Observable<ChildOutput> {
        let child = Observable<ChildOutput>(parent: self)
        return observeChange { [unowned child] value in
            listener(value, child)
        }.asParent(of: child)
    }
    
    /// Map this Observable into another form of Observable
    /// - Parameter mapper: Closure that takes the value from this Observable and return its mapped value
    /// - Returns: New Observable with mapped value
    public func mapped<Mapped>(_ mapper: @escaping (Output) -> Mapped) -> Observable<Mapped> {
        addChildObservable { value, child in
            child.accept(value.mapped(mapper))
        }
    }
    
    /// Map this Observable into another form of Observable while ignoring null value
    /// - Parameter projection: Closure that takes the value from this Observable and return its optional mapped value
    /// - Returns: New Observable with mapped value
    public func compactMapped<Mapped>(_ mapper: @escaping (Output) -> Mapped?) -> Observable<Mapped> {
        var buffer: Mapped?
        return addChildObservable { value, child in
            guard let mapped = value.compactMapped(mapper) else {
                guard let old = value.old, let oldMapped = mapper(old) else { return }
                buffer = oldMapped
                return
            }
            if let previousBuffer = buffer {
                buffer = nil
                child.accept(mapped.with(old: previousBuffer))
            } else {
                child.accept(mapped)
            }
        }
    }
    
    /// Filter this Observable to include only the allowed value
    /// - Parameter shouldInclude: Closure that takes value from this Observable and returns Bool indicated the value is allowed or not
    /// - Returns: New Observable with filtered value
    @inlinable public func filter(_ shouldInclude: @escaping (Output) -> Bool) -> Observable<Output> {
        filterChange { _, new in
            shouldInclude(new)
        }
    }
    
    /// Filter this Observable to include only the allowed changes
    /// - Parameter comparator: Closure that takes old value if any and new value from this Observable and returns Bool indicated the changes is allowed or not
    /// - Returns: New Observable with filtered value
    public func filterChange(_ shouldInclude: @escaping (Output?, Output) -> Bool) -> Observable<Output> {
        var buffer: Output?
        return addChildObservable { value, child in
            guard shouldInclude(value.old, value.new) else {
                buffer = value.old
                return
            }
            if let previousBuffer = buffer {
                buffer = nil
                child.accept(value.with(old: previousBuffer))
            } else {
                child.accept(value)
            }
        }
    }
    
    /// Filter this Observable to ignore some value
    /// - Parameter shouldInclude: Closure that takes value from this Observable and returns Bool indicated the value is ignored or not
    /// - Returns: New Observable with filtered value
    @inlinable public func ignore(_ shouldIgnore: @escaping (Output) -> Bool) -> Observable<Output> {
        filter { !shouldIgnore($0) }
    }
    
    /// Run the observer in the given DispatchQueue synchronously if already in the given DispatchQueue
    /// - Parameter queue: DispatchQueue where the next observer will be run
    /// - Returns: New Observable with DispatchQueue
    public func observe(on queue: DispatchQueue) -> Observable<Output> {
        addChildObservable { value, child in
            queue.asyncIfNeeded {
                child.accept(value)
            }
        }
    }
    
    /// Run the observer in the given DispatchQueue asynchronously
    /// - Parameter queue: DispatchQueue where the next observer will be run
    /// - Returns: New Observable with DispatchQueue
    public func dispatch(on queue: DispatchQueue) -> Observable<Output> {
        addChildObservable { value, child in
            queue.async {
                child.accept(value)
            }
        }
    }
    
    /// Run the next observer in the main thread synchronously if already in the given DispatchQueue
    /// - Returns: New Observable that will run the observer in the MainThread
    @inlinable public func observeOnMain() -> Observable<Output> {
        observe(on: .main)
    }
    
    /// Run the next observer in the main thread asynchronously
    /// - Returns: New Observable that will run the observer in the MainThread
    @inlinable public func dispatchOnMain() -> Observable<Output> {
        dispatch(on: .main)
    }
    
    /// Run the next observer in the background thread asynchronously
    /// - Returns: New Observable that will run the observer in the background thread
    @inlinable public func dispatchOnBackground() -> Observable<Output> {
        dispatch(on: .global(qos: .background))
    }
    
    /// Throttled the value coming to the next observer by the given interval
    /// Multiple value coming one after another will be blocked until the given interval
    /// After blocking is finished, it will then consume the last value blocked to the next listeners
    /// - Parameter minimumCallInterval: Minimum interval the value can be consumed by observer
    /// - Returns: New throttled Observable
    public func throttled(by minimumCallInterval: TimeInterval) -> Observable<Output> {
        var pendingBuffer: Changes<Output>?
        var lastBlockedTime: Date = .distantPast
        return addChildObservable { value, child in
            guard lastBlockedTime.timeIntervalUntilNow > minimumCallInterval else {
                pendingBuffer = value
                return
            }
            lastBlockedTime = Date()
            child.accept(value)
            (DispatchQueue.current ?? .main).asyncAfter(deadline: .now() + minimumCallInterval) { [weak child] in
                guard let pending = pendingBuffer, let child = child else {
                    return
                }
                pendingBuffer = nil
                lastBlockedTime = Date()
                child.accept(pending.with(old: value.new))
            }
        }
    }
}

extension Date {
    @inlinable var timeIntervalUntilNow: TimeInterval {
        -timeIntervalSinceNow
    }
}

// MARK: Observable + Equatable

extension Observable where Output: Equatable {
    /// Ignore equal value coming from this Observable
    /// - Returns:Observable that only give unique value to the next listeners
    @inlinable public func distinct() -> Observable<Output> {
        filterChange { $0 != $1 }
    }
    
    @inlinable public func ignore(_ value: Output) -> Observable<Output> {
        ignore { $0 == value }
    }
}
