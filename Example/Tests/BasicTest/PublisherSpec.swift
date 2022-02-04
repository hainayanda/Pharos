//
//  PublisherSpec.swift
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

class PublisherSpec: QuickSpec {
    
    override func spec() {
        var publisher: Publisher<String>!
        beforeEach {
            publisher = Publisher()
        }
        it("should publish to subscriber") {
            let changeWrapper = listenDidSet(for: publisher)
            let newState: String = .randomString(length: 18)
            publisher.publish(value: newState)
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(old: nil, new: newState, source: publisher),
                setCount: 1
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
        expect(changes.old == expectedChanges.old).to(beTrue())
        expect(notifiedChanges.setCount).to(equal(setCount))
    }

