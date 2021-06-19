//
//  UIButtonRelayCollectionSpec.swift
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

class UIButtonRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UIButtonRelayCollection") {
            var view: UIButton!
            beforeEach {
                view = UIButton()
            }
            it("should relay automaticallyUpdatesBackgroundConfiguration") {
                if #available(iOS 13.4, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bondableRelays.isPointerInteractionEnabled,
                        keyPath: \.isPointerInteractionEnabled
                    )
                }
            }
            it("should relay contentEdgeInsets") {
                testInsetsRelay(
                    for: view,
                    relay: view.bondableRelays.contentEdgeInsets,
                    keyPath: \.contentEdgeInsets
                )
            }
            it("should relay titleEdgeInsets") {
                testInsetsRelay(
                    for: view,
                    relay: view.bondableRelays.titleEdgeInsets,
                    keyPath: \.titleEdgeInsets
                )
            }
            it("should relay reversesTitleShadowWhenHighlighted") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.reversesTitleShadowWhenHighlighted,
                    keyPath: \.reversesTitleShadowWhenHighlighted
                )
            }
            it("should relay imageEdgeInsets") {
                testInsetsRelay(
                    for: view,
                    relay: view.bondableRelays.imageEdgeInsets,
                    keyPath: \.imageEdgeInsets
                )
            }
            it("should relay adjustsImageWhenHighlighted") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.adjustsImageWhenHighlighted,
                    keyPath: \.adjustsImageWhenHighlighted
                )
            }
            it("should relay adjustsImageWhenDisabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.adjustsImageWhenDisabled,
                    keyPath: \.adjustsImageWhenDisabled
                )
            }
            it("should relay showsTouchWhenHighlighted") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.showsTouchWhenHighlighted,
                    keyPath: \.showsTouchWhenHighlighted
                )
            }
        }
    }
}
#endif
