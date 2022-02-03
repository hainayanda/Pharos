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
                testImageRelay(
                    for: view,
                    relay: view.bindables.image,
                    keyPath: \.image
                )
            }
            it("should relay highlightedImage") {
                if #available(iOS 14, *) {
                    testImageRelay(
                        for: view,
                        relay: view.bindables.highlightedImage,
                        keyPath: \.highlightedImage
                    )
                }
            }
            it("should relay isUserInteractionEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isUserInteractionEnabled,
                    keyPath: \.isUserInteractionEnabled
                )
            }
            it("should relay isHighlighted") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isHighlighted,
                    keyPath: \.isHighlighted
                )
            }
            it("should relay animationImages") {
                testArrayImageRelay(
                    for: view,
                    relay: view.bindables.animationImages,
                    keyPath: \.animationImages
                )
            }
            it("should relay highlightedAnimationImages") {
                testArrayImageRelay(
                    for: view,
                    relay: view.bindables.highlightedAnimationImages,
                    keyPath: \.highlightedAnimationImages
                )
            }
            it("should relay animationDuration") {
                testTimeIntervalRelay(
                    for: view,
                    relay: view.bindables.animationDuration,
                    keyPath: \.animationDuration
                )
            }
            it("should relay animationRepeatCount") {
                testIntRelay(
                    for: view,
                    relay: view.bindables.animationRepeatCount,
                    keyPath: \.animationRepeatCount
                )
            }
        }
    }
}
#endif
