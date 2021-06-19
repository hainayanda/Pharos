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
                testFloatRelay(
                    for: view,
                    relay: view.bondableRelays.minimumValue,
                    keyPath: \.minimumValue
                )
            }
            it("should relay maximumValue") {
                testFloatRelay(
                    for: view,
                    relay: view.bondableRelays.maximumValue,
                    keyPath: \.maximumValue
                )
            }
            it("should relay minimumValueImage") {
                testImageRelay(
                    for: view,
                    relay: view.bondableRelays.minimumValueImage,
                    keyPath: \.minimumValueImage
                )
            }
            it("should relay maximumValueImage") {
                testImageRelay(
                    for: view,
                    relay: view.bondableRelays.maximumValueImage,
                    keyPath: \.maximumValueImage
                )
            }
            it("should relay isContinuous") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.isContinuous,
                    keyPath: \.isContinuous
                )
            }
            it("should relay minimumTrackTintColor") {
                testColorRelay(
                    for: view,
                    relay: view.bondableRelays.minimumTrackTintColor,
                    keyPath: \.minimumTrackTintColor
                )
            }
            it("should relay maximumTrackTintColor") {
                testColorRelay(
                    for: view,
                    relay: view.bondableRelays.maximumTrackTintColor,
                    keyPath: \.maximumTrackTintColor
                )
            }
            it("should relay thumbTintColor") {
                testColorRelay(
                    for: view,
                    relay: view.bondableRelays.thumbTintColor,
                    keyPath: \.thumbTintColor
                )
            }
        }
    }
}
#endif
