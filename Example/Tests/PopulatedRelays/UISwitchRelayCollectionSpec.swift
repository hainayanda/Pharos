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
                testRelay(
                    for: view,
                    relay: view.bondableRelays.onTintColor,
                    keyPath: \.onTintColor
                )
            }
            it("should relay thumbTintColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.thumbTintColor,
                    keyPath: \.thumbTintColor
                )
            }
            it("should relay onImage") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.onImage,
                    keyPath: \.onImage
                )
            }
            it("should relay offImage") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.offImage,
                    keyPath: \.offImage
                )
            }
            it("should relay isOn") {
                if #available(iOS 14.0, *) {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.isOn,
                        keyPath: \.isOn
                    )
                }
            }
        }
    }
}
#endif
