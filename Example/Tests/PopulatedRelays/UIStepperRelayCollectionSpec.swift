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

class UIStepperRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UIStepperRelayCollection") {
            var view: UIStepper!
            beforeEach {
                view = UIStepper()
            }
            it("should relay isContinuous") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isContinuous,
                    keyPath: \.isContinuous
                )
            }
            it("should relay autorepeat") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.autorepeat,
                    keyPath: \.autorepeat
                )
            }
            it("should relay wraps") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.wraps,
                    keyPath: \.wraps
                )
            }
            it("should relay minimumValue") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.minimumValue,
                    keyPath: \.minimumValue
                )
            }
            it("should relay maximumValue") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.maximumValue,
                    keyPath: \.maximumValue
                )
            }
            it("should relay stepValue") {
                let newValue = Double.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bondableRelays.stepValue,
                    keyPath: \.stepValue,
                    with: newValue) { changes, oldValue in
                    expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
                    expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
                }
            }
        }
    }
}
#endif
