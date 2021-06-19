//
//  UIImageViewRelayCollectionSpec.swift
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

class UIImageViewRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UIImageViewRelayCollection") {
            var view: UIImageView!
            beforeEach {
                view = UIImageView()
            }
            it("should relay image") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.image,
                    keyPath: \.image
                )
            }
            it("should relay highlightedImage") {
                if #available(iOS 14, *) {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.highlightedImage,
                        keyPath: \.highlightedImage
                    )
                }
            }
            it("should relay isUserInteractionEnabled") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isUserInteractionEnabled,
                    keyPath: \.isUserInteractionEnabled
                )
            }
            it("should relay isHighlighted") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isHighlighted,
                    keyPath: \.isHighlighted
                )
            }
            it("should relay animationImages") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.animationImages,
                    keyPath: \.animationImages
                )
            }
            it("should relay highlightedAnimationImages") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.highlightedAnimationImages,
                    keyPath: \.highlightedAnimationImages
                )
            }
            it("should relay animationDuration") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.animationDuration,
                    keyPath: \.animationDuration
                )
            }
            it("should relay animationRepeatCount") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.animationRepeatCount,
                    keyPath: \.animationRepeatCount
                )
            }
        }
    }
}
#endif
