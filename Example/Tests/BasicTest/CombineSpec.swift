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

class CombineSpec: QuickSpec {
    
    override func spec() {
        var intialState: String!
        var subject: Subject<String>!
        beforeEach {
            intialState = .randomString(length: 9)
            subject = Subject(wrappedValue: intialState)
        }
        it("should combine 2 subjects") {
            let subject2 = Subject<Int>(wrappedValue: 0)
            let changeWrapper = listenDidSet(for: subject.compactCombine(with: subject2))
            let newState1: String = .randomString(length: 18)
            let newState2: Int = .random(in: -1000 ..< 1000)
            subject.wrappedValue = newState1
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: (newState1, 0), old: (intialState, 0)),
                setCount: 1
            )
            subject2.wrappedValue = newState2
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: (newState1, newState2), old: (newState1, 0)),
                setCount: 2
            )
        }
        it("should combine 3 subjects") {
            let subject2 = Subject<Int>(wrappedValue: 0)
            let subject3 = Subject<Bool>(wrappedValue: false)
            let changeWrapper = listenDidSet(for: subject.compactCombine(with: subject2, subject3))
            let newState1: String = .randomString(length: 18)
            let newState2: Int = .random(in: -1000 ..< 1000)
            subject.wrappedValue = newState1
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    new: (newState1, 0, false), old: (intialState, 0, false)
                ),
                setCount: 1
            )
            subject2.wrappedValue = newState2
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    new: (newState1, newState2, false), old: (newState1, 0, false)
                ),
                setCount: 2
            )
            subject3.wrappedValue = true
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    new: (newState1, newState2, true), old: (newState1, newState2, false)
                ),
                setCount: 3
            )
        }
        it("should combine 4 subjects") {
            let subject2 = Subject<Int>(wrappedValue: 0)
            let subject3 = Subject<Bool>(wrappedValue: false)
            let subject4 = Subject<Int>(wrappedValue: 0)
            let changeWrapper = listenDidSet(for: subject.compactCombine(with: subject2, subject3, subject4))
            let newState1: String = .randomString(length: 18)
            let newState2: Int = .random(in: -1000 ..< 1000)
            let newState4: Int = .random(in: -1000 ..< 1000)
            subject.wrappedValue = newState1
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    new: (newState1, 0, false, 0), old: (intialState, 0, false, 0)
                ),
                setCount: 1
            )
            subject2.wrappedValue = newState2
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    new: (newState1, newState2, false, 0), old: (newState1, 0, false, 0)
                ),
                setCount: 2
            )
            subject3.wrappedValue = true
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    new: (newState1, newState2, true, 0), old: (newState1, newState2, false, 0)
                ),
                setCount: 3
            )
            subject4.wrappedValue = newState4
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    new: (newState1, newState2, true, newState4), old: (newState1, newState2, true, 0)
                ),
                setCount: 4
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

private func listenDidSet<State: Equatable>(for subject: Observable<State>, retainUntilState changes: Changes<State>) -> ChangesClassWrapper<State> {
    let changeWrapper = ChangesClassWrapper<State>()
    subject
        .observeChange { changes in
            changeWrapper.changes = changes
        }.retainUntil { $0 == changes }
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

private func thenAssert<State1: Equatable, State2: Equatable>(
    _ notifiedChanges: ChangesClassWrapper<(State1, State2)>,
    shouldSimilarWith expectedChanges: Changes<(State1, State2)>,
    setCount: Int) {
        guard let changes = notifiedChanges.changes else {
            fail()
            return
        }
        expect(changes.new).to(equal(expectedChanges.new))
        expect(changes.old).to(equal(expectedChanges.old))
        expect(notifiedChanges.setCount).to(equal(setCount))
    }

private func thenAssert<State1: Equatable, State2: Equatable, State3: Equatable>(
    _ notifiedChanges: ChangesClassWrapper<(State1, State2, State3)>,
    shouldSimilarWith expectedChanges: Changes<(State1, State2, State3)>,
    setCount: Int) {
        guard let changes = notifiedChanges.changes else {
            fail()
            return
        }
        expect(changes.new).to(equal(expectedChanges.new))
        expect(changes.old).to(equal(expectedChanges.old))
        expect(notifiedChanges.setCount).to(equal(setCount))
    }

private func thenAssert<State1: Equatable, State2: Equatable, State3: Equatable, State4: Equatable>(
    _ notifiedChanges: ChangesClassWrapper<(State1, State2, State3, State4)>,
    shouldSimilarWith expectedChanges: Changes<(State1, State2, State3, State4)>,
    setCount: Int) {
        guard let changes = notifiedChanges.changes else {
            fail()
            return
        }
        expect(changes.new).to(equal(expectedChanges.new))
        expect(changes.old).to(equal(expectedChanges.old))
        expect(notifiedChanges.setCount).to(equal(setCount))
    }
