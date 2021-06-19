//
//  UISliderRelayCollectionSpec.swift
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

class UISliderRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UISliderRelayCollection") {
            var view: UISlider!
            beforeEach {
                view = UISlider()
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
            it("should relay minimumValueImage") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.minimumValueImage,
                    keyPath: \.minimumValueImage
                )
            }
            it("should relay maximumValueImage") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.maximumValueImage,
                    keyPath: \.maximumValueImage
                )
            }
            it("should relay isContinuous") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isContinuous,
                    keyPath: \.isContinuous
                )
            }
            it("should relay minimumTrackTintColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.minimumTrackTintColor,
                    keyPath: \.minimumTrackTintColor
                )
            }
            it("should relay maximumTrackTintColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.maximumTrackTintColor,
                    keyPath: \.maximumTrackTintColor
                )
            }
            it("should relay thumbTintColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.thumbTintColor,
                    keyPath: \.thumbTintColor
                )
            }
        }
    }
}
#endif
