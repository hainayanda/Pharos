//
//  ObservableSpec.swift
//  Pharos_Tests
//
//  Created by Nayanda Haberty on 04/02/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
#if canImport(UIKit)
import UIKit
#endif
@testable import Pharos
// swiftlint:disable function_body_length

class ObservableSpec: QuickSpec {
    
    override func spec() {
        var intialState: String!
        var subject: Subject<String>!
        beforeEach {
            intialState = .randomString(length: 9)
            subject = Subject(wrappedValue: intialState)
        }
        it("should notify subscriber") {
            let changeWrapper = listenDidSet(for: subject)
            let newState: String = .randomString(length: 18)
            subject.wrappedValue = newState
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState, old: intialState),
                setCount: 1
            )
        }
        it("should fire to the one request it") {
            var firstObserverCalled: Bool = false
            var secondObserverCalled: Bool = false
            var thirdObserverCalled: Bool = false
            var fourthObserverCalled: Bool = false
            subject.observe { _ in
                firstObserverCalled = true
            }.retain()
            
            subject.filter { _ in true }.observe { _ in
                secondObserverCalled = true
            }.retain()
            
            subject.observe { _ in
                thirdObserverCalled = true
            }
            .retain()
            .fire()
            
            expect(firstObserverCalled).to(beFalse())
            expect(secondObserverCalled).to(beFalse())
            expect(thirdObserverCalled).to(beTrue())
            
            thirdObserverCalled = false
            
            subject.filter { _ in true }.observe { _ in
                fourthObserverCalled = true
            }
            .retain()
            .fire()
            
            expect(firstObserverCalled).to(beFalse())
            expect(secondObserverCalled).to(beFalse())
            expect(thirdObserverCalled).to(beFalse())
            expect(fourthObserverCalled).to(beTrue())
        }
        it("should retain subscriber using retainer") {
            var retainer: Retainer? = Retainer()
            let changeWrapper = listenDidSet(for: subject, retainTo: retainer!)
            let newState: String = .randomString(length: 18)
            subject.wrappedValue = newState
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState, old: intialState),
                setCount: 1
            )
            retainer = nil
            subject.wrappedValue = .randomString(length: 18)
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState, old: intialState),
                setCount: 1
            )
        }
        it("should retain subscriber using retainer") {
            var retainer: Retainer? = Retainer()
            let changeWrapper = listenDidSet(for: subject, retainTo: retainer!)
            let newState: String = .randomString(length: 18)
            subject.wrappedValue = newState
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState, old: intialState),
                setCount: 1
            )
            retainer = nil
            subject.wrappedValue = .randomString(length: 18)
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState, old: intialState),
                setCount: 1
            )
        }
        it("should retain subscriber for n count") {
            let changeWrapper = listenDidSet(for: subject, retainUntilStateCount: 1)
            let newState: String = .randomString(length: 18)
            subject.wrappedValue = newState
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState, old: intialState),
                setCount: 1
            )
            subject.wrappedValue = .randomString(length: 18)
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState, old: intialState),
                setCount: 1
            )
        }
        it("should retain subscriber for given timeinterval") {
            let newState: String = .randomString(length: 18)
            let expectedChanges = Changes(new: newState, old: intialState)
            let changeWrapper = listenDidSet(for: subject, retainUntil: 0.5)
            subject.wrappedValue = newState
            thenAssert(
                changeWrapper,
                shouldSimilarWith: expectedChanges,
                setCount: 1
            )
            waitUntil { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: done)
            }
            subject.wrappedValue = .randomString(length: 18)
            thenAssert(
                changeWrapper,
                shouldSimilarWith: expectedChanges,
                setCount: 1
            )
        }
        it("should ignore state") {
            let changeWrapper = listenDidSet(for: subject.ignore { _ in true })
            subject.wrappedValue = .randomString(length: 18)
            expect(changeWrapper.changes).to(beNil())
        }
        it("should delay notification") {
            let changeWrapper = listenDidSet(for: subject, delayBy: 0.5)
            let newState1: String = .randomString(length: 18)
            let newState2: String = .randomString(length: 18)
            subject.wrappedValue = newState1
            subject.wrappedValue = newState2
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState1, old: intialState),
                andAfter: .milliseconds(50),
                shouldSimilarWith: Changes(new: newState2, old: newState1)
            )
        }
        it("should map subject") {
            let changeWrapper = listenDidSet(for: subject.mapped { $0.count })
            let newState: String = .randomString(length: 18)
            subject.wrappedValue = newState
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState.count, old: intialState.count),
                setCount: 1
            )
        }
        it("should merge subjects") {
            let subject2 = Subject<String>(wrappedValue: intialState)
            let merged = subject.merged(with: subject2)
            let changeWrapper = listenDidSet(for: merged)
            let newState1: String = .randomString(length: 18)
            let newState2: String = .randomString(length: 18)
            subject.wrappedValue = newState1
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState1, old: intialState),
                setCount: 1
            )
            subject2.wrappedValue = newState2
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState2, old: newState1),
                setCount: 2
            )
        }
    }
}

// MARK: Given

private func listenDidSet<State>(for subject: Observable<State>) -> ChangesClassWrapper<State> {
    let changeWrapper = ChangesClassWrapper<State>()
    subject
        .observeChange { changes in
            changeWrapper.changes = changes
        }.retain()
    return changeWrapper
}

private func listenDidSet<State>(for subject: Observable<State>, delayBy interval: TimeInterval) -> ChangesClassWrapper<State> {
    let changeWrapper = ChangesClassWrapper<State>()
    subject
        .throttled(by: interval)
        .observeChange { changes in
            changeWrapper.changes = changes
        }
        .retain()
    return changeWrapper
}

private func listenDidSet<State>(for subject: Observable<State>, retainTo retainer: Retainer) -> ChangesClassWrapper<State> {
    let changeWrapper = ChangesClassWrapper<State>()
    subject
        .observeChange { changes in
            changeWrapper.changes = changes
        }.retained(by: retainer)
    return changeWrapper
}

private func listenDidSet<State>(for subject: Observable<State>, retainUntilStateCount maxCount: Int) -> ChangesClassWrapper<State> {
    let changeWrapper = ChangesClassWrapper<State>()
    subject
        .observeChange { changes in
            changeWrapper.changes = changes
        }.retainUntil(nextEventCount: maxCount)
    return changeWrapper
}

private func listenDidSet<State>(for subject: Observable<State>, retainUntil timeInterval: TimeInterval) -> ChangesClassWrapper<State> {
    let changeWrapper = ChangesClassWrapper<State>()
    subject
        .observeChange { changes in
            changeWrapper.changes = changes
        }.retain(for: 0.5)
    return changeWrapper
}

// MARK: When

// MARK: Assertion

private func thenAssert<State: Equatable>(
    _ notifiedChanges: ChangesClassWrapper<State>,
    shouldSimilarWith expectedChanges: Changes<State>, setCount: Int) {
        guard let changes = notifiedChanges.changes else {
            fail()
            return
        }
        expect(changes.new).to(equal(expectedChanges.new))
        expect(changes.old).to(equal(expectedChanges.old))
        expect(notifiedChanges.setCount).to(equal(setCount))
    }

private func thenAssert<State: Equatable>(
    _ notifiedChanges: ChangesClassWrapper<State>,
    shouldSimilarWith expectedChanges: Changes<State>,
    after timeInterval: DispatchTimeInterval,
    setCount: Int) {
        expect(notifiedChanges.changes?.new).toEventually(equal(expectedChanges.new), pollInterval: timeInterval)
        expect(notifiedChanges.changes?.old).toEventually(equal(expectedChanges.old), pollInterval: timeInterval)
        expect(notifiedChanges.setCount).toEventually(equal(setCount), pollInterval: timeInterval)
    }
private func thenAssert<State: Equatable>(
    _ notifiedChanges: ChangesClassWrapper<State>,
    shouldSimilarWith expectedChanges: Changes<State>,
    andAfter timeInterval: DispatchTimeInterval,
    shouldSimilarWith nextexpectedChanges: Changes<State>) {
        let setCount = notifiedChanges.setCount
        thenAssert(
            notifiedChanges,
            shouldSimilarWith: expectedChanges,
            setCount: setCount
        )
        thenAssert(
            notifiedChanges,
            shouldSimilarWith: nextexpectedChanges,
            after: timeInterval,
            setCount: setCount + 1
        )
    }
