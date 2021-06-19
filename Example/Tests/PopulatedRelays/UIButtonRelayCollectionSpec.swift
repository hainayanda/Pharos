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
            context("TwoWayRelay") {
                it("should relay automaticallyUpdatesBackgroundConfiguration") {
                    if #available(iOS 13.4, *) {
                        testRelay(
                            for: view,
                            relay: view.bondableRelays.isPointerInteractionEnabled,
                            keyPath: \.isPointerInteractionEnabled
                        )
                    }
                }
                it("should relay contentEdgeInsets") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.contentEdgeInsets,
                        keyPath: \.contentEdgeInsets
                    )
                }
                it("should relay titleEdgeInsets") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.titleEdgeInsets,
                        keyPath: \.titleEdgeInsets
                    )
                }
                it("should relay reversesTitleShadowWhenHighlighted") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.reversesTitleShadowWhenHighlighted,
                        keyPath: \.reversesTitleShadowWhenHighlighted
                    )
                }
                it("should relay imageEdgeInsets") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.imageEdgeInsets,
                        keyPath: \.imageEdgeInsets
                    )
                }
                it("should relay adjustsImageWhenHighlighted") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.adjustsImageWhenHighlighted,
                        keyPath: \.adjustsImageWhenHighlighted
                    )
                }
                it("should relay adjustsImageWhenDisabled") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.adjustsImageWhenDisabled,
                        keyPath: \.adjustsImageWhenDisabled
                    )
                }
                it("should relay showsTouchWhenHighlighted") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.showsTouchWhenHighlighted,
                        keyPath: \.showsTouchWhenHighlighted
                    )
                }
            }
        }
    }
}
#endif
