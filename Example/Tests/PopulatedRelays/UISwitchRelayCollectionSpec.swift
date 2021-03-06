//
//  UISwitchRelayCollectionSpec.swift
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

class UISwitchRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UISwitchRelayCollection") {
            var view: UISwitch!
            beforeEach {
                view = UISwitch()
            }
            it("should relay onTintColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.onTintColor,
                    keyPath: \.onTintColor
                )
            }
            it("should relay thumbTintColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.thumbTintColor,
                    keyPath: \.thumbTintColor
                )
            }
            it("should relay onImage") {
                testImageRelay(
                    for: view,
                    relay: view.bindables.onImage,
                    keyPath: \.onImage
                )
            }
            it("should relay offImage") {
                testImageRelay(
                    for: view,
                    relay: view.bindables.offImage,
                    keyPath: \.offImage
                )
            }
            it("should relay isOn") {
                if #available(iOS 14.0, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bindables.isOn,
                        keyPath: \.isOn
                    )
                }
            }
        }
    }
}
#endif
