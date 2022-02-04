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
                shouldSimilarWith: Changes(old: (intialState, 0), new: (newState1, 0), source: subject),
                setCount: 1
            )
            subject2.wrappedValue = newState2
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(old: (newState1, 0), new: (newState1, newState2), source: subject2),
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
                    old: (intialState, 0, false),
                    new: (newState1, 0, false),
                    source: subject
                ),
                setCount: 1
            )
            subject2.wrappedValue = newState2
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    old: (newState1, 0, false),
                    new: (newState1, newState2, false),
                    source: subject2
                ),
                setCount: 2
            )
            subject3.wrappedValue = true
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    old: (newState1, newState2, false),
                    new: (newState1, newState2, true),
                    source: subject3
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
                    old: (intialState, 0, false, 0),
                    new: (newState1, 0, false, 0),
                    source: subject
                ),
                setCount: 1
            )
            subject2.wrappedValue = newState2
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    old: (newState1, 0, false, 0),
                    new: (newState1, newState2, false, 0),
                    source: subject2
                ),
                setCount: 2
            )
            subject3.wrappedValue = true
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    old: (newState1, newState2, false, 0),
                    new: (newState1, newState2, true, 0),
                    source: subject3
                ),
                setCount: 3
            )
            subject4.wrappedValue = newState4
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(
                    old: (newState1, newState2, true, 0),
                    new: (newState1, newState2, true, newState4),
                    source: subject4
                ),
                setCount: 4
            )
        }
    }
}

// MARK: Given

fileprivate func listenDidSet<State>(for subject: Observable<State>) -> ChangesClassWrapper<State> {
    let changeWrapper = ChangesClassWrapper<State>()
    subject
        .whenDidSet { changes in
            changeWrapper.changes = changes
        }.retain()
    return changeWrapper
}

fileprivate func listenDidSet<State>(for subject: Observable<State>, delayBy interval: TimeInterval) -> ChangesClassWrapper<State> {
    let changeWrapper = ChangesClassWrapper<State>()
    subject
        .whenDidSet { changes in
            changeWrapper.changes = changes
        }.multipleSetDelayed(by: interval)
        .retain()
    return changeWrapper
}

fileprivate func listenDidSet<State>(for subject: Observable<State>, retainTo retainer: Retainer) -> ChangesClassWrapper<State> {
    let changeWrapper = ChangesClassWrapper<State>()
    subject
        .whenDidSet { changes in
            changeWrapper.changes = changes
        }.retained(by: retainer)
    return changeWrapper
}

fileprivate func listenDidSet<State>(for subject: Observable<State>, retainUntilStateCount maxCount: Int) -> ChangesClassWrapper<State> {
    let changeWrapper = ChangesClassWrapper<State>()
    subject
        .whenDidSet { changes in
            changeWrapper.changes = changes
        }.retainUntil(nextEventCount: maxCount)
    return changeWrapper
}

fileprivate func listenDidSet<State: Equatable>(for subject: Observable<State>, retainUntilState changes: Changes<State>) -> ChangesClassWrapper<State> {
    let changeWrapper = ChangesClassWrapper<State>()
    subject
        .whenDidSet { changes in
            changeWrapper.changes = changes
        }.retainUntil { $0 == changes }
    return changeWrapper
}

// MARK: When

// MARK: Assertion

fileprivate func thenAssert<State: Equatable>(
    _ notifiedChanges: ChangesClassWrapper<State>,
    shouldSimilarWith expectedChanges: Changes<State>, setCount: Int) {
        guard let changes = notifiedChanges.changes else {
            fail()
            return
        }
        expect(changes.source === expectedChanges.source).to(beTrue())
        expect(changes.new).to(equal(expectedChanges.new))
        expect(changes.old).to(equal(expectedChanges.old))
        expect(notifiedChanges.setCount).to(equal(setCount))
    }

fileprivate func thenAssert<State: Equatable>(
    _ notifiedChanges: ChangesClassWrapper<State>,
    shouldSimilarWith expectedChanges: Changes<State>,
    after timeInterval: DispatchTimeInterval,
    setCount: Int) {
        expect(notifiedChanges.changes?.source === expectedChanges.source).toEventually(beTrue(), pollInterval: timeInterval)
        expect(notifiedChanges.changes?.new).toEventually(equal(expectedChanges.new), pollInterval: timeInterval)
        expect(notifiedChanges.changes?.old).toEventually(equal(expectedChanges.old), pollInterval: timeInterval)
        expect(notifiedChanges.setCount).toEventually(equal(setCount), pollInterval: timeInterval)
    }

fileprivate func thenAssert<State1: Equatable, State2: Equatable>(
    _ notifiedChanges: ChangesClassWrapper<(State1, State2)>,
    shouldSimilarWith expectedChanges: Changes<(State1, State2)>,
    setCount: Int) {
        guard let changes = notifiedChanges.changes else {
            fail()
            return
        }
        expect(changes.source === expectedChanges.source).to(beTrue())
        expect(changes.new).to(equal(expectedChanges.new))
        expect(changes.old).to(equal(expectedChanges.old))
        expect(notifiedChanges.setCount).to(equal(setCount))
    }

fileprivate func thenAssert<State1: Equatable, State2: Equatable, State3: Equatable>(
    _ notifiedChanges: ChangesClassWrapper<(State1, State2, State3)>,
    shouldSimilarWith expectedChanges: Changes<(State1, State2, State3)>,
    setCount: Int) {
        guard let changes = notifiedChanges.changes else {
            fail()
            return
        }
        expect(changes.source === expectedChanges.source).to(beTrue())
        expect(changes.new).to(equal(expectedChanges.new))
        expect(changes.old).to(equal(expectedChanges.old))
        expect(notifiedChanges.setCount).to(equal(setCount))
    }

fileprivate func thenAssert<State1: Equatable, State2: Equatable, State3: Equatable, State4: Equatable>(
    _ notifiedChanges: ChangesClassWrapper<(State1, State2, State3, State4)>,
    shouldSimilarWith expectedChanges: Changes<(State1, State2, State3, State4)>,
    setCount: Int) {
        guard let changes = notifiedChanges.changes else {
            fail()
            return
        }
        expect(changes.source === expectedChanges.source).to(beTrue())
        expect(changes.new).to(equal(expectedChanges.new))
        expect(changes.old).to(equal(expectedChanges.old))
        expect(notifiedChanges.setCount).to(equal(setCount))
    }
