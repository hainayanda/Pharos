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
            publisher.publish(newState)
            thenAssert(
                changeWrapper,
                shouldSimilarWith: Changes(new: newState, old: nil),
                setCount: 1
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
        expect(changes.old == expectedChanges.old).to(beTrue())
        expect(notifiedChanges.setCount).to(equal(setCount))
    }
