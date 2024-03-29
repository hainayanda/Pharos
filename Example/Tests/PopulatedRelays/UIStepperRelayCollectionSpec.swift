//
//  UIStepperRelayCollectionSpec.swift
//  Pharos_Tests
//
//  Created by Nayanda Haberty on 19/06/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Pharos
#if canImport(UIKit)
import UIKit
// swiftlint:disable function_body_length

class UIStepperRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UIStepperRelayCollection") {
            var view: UIStepper!
            beforeEach {
                view = UIStepper()
            }
            it("should relay isContinuous") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isContinuous,
                    keyPath: \.isContinuous
                )
            }
            it("should relay autorepeat") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.autorepeat,
                    keyPath: \.autorepeat
                )
            }
            it("should relay wraps") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.wraps,
                    keyPath: \.wraps
                )
            }
            it("should relay minimumValue") {
                let new = Double.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bindables.minimumValue,
                    keyPath: \.minimumValue,
                    with: new) { changes, old in
                    expect(abs(changes.new - new)).to(beLessThan(0.0001))
                    expect(abs(changes.old - old)).to(beLessThan(0.0001))
                }
            }
            it("should relay maximumValue") {
                let new = Double.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bindables.maximumValue,
                    keyPath: \.maximumValue,
                    with: new) { changes, old in
                    expect(abs(changes.new - new)).to(beLessThan(0.0001))
                    expect(abs(changes.old - old)).to(beLessThan(0.0001))
                }
            }
            it("should relay stepValue") {
                let new = Double.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bindables.stepValue,
                    keyPath: \.stepValue,
                    with: new) { changes, old in
                    expect(abs(changes.new - new)).to(beLessThan(0.0001))
                    expect(abs(changes.old - old)).to(beLessThan(0.0001))
                }
            }
        }
    }
}
#endif
