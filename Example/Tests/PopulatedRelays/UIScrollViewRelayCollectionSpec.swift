//
//  UIScrollViewRelayCollectionSpec.swift
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

class UIScrollViewRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UIScrollViewRelayCollection") {
            var view: UIScrollView!
            beforeEach {
                view = UIScrollView()
            }
            it("should relay contentSize") {
                testSizeRelay(
                    for: view,
                    relay: view.bindables.contentSize,
                    keyPath: \.contentSize
                )
            }
            it("should relay contentInset") {
                testInsetsRelay(
                    for: view,
                    relay: view.bindables.contentInset,
                    keyPath: \.contentInset
                )
            }
            it("should relay delegate") {
                testRelay(
                    for: view,
                    relay: view.bindables.delegate,
                    keyPath: \.delegate,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
                    guard let spec = changes.new as? UIScrollViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay isDirectionalLockEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isDirectionalLockEnabled,
                    keyPath: \.isDirectionalLockEnabled
                )
            }
            it("should relay bounces") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.bounces,
                    keyPath: \.bounces
                )
            }
            it("should relay alwaysBounceVertical") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.alwaysBounceVertical,
                    keyPath: \.alwaysBounceVertical
                )
            }
            it("should relay alwaysBounceHorizontal") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.alwaysBounceHorizontal,
                    keyPath: \.alwaysBounceHorizontal
                )
            }
            it("should relay isPagingEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isPagingEnabled,
                    keyPath: \.isPagingEnabled
                )
            }
            it("should relay isUserInteractionEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isUserInteractionEnabled,
                    keyPath: \.isUserInteractionEnabled
                )
            }
            it("should relay isScrollEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isScrollEnabled,
                    keyPath: \.isScrollEnabled
                )
            }
            it("should relay showsVerticalScrollIndicator") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.showsVerticalScrollIndicator,
                    keyPath: \.showsVerticalScrollIndicator
                )
            }
            it("should relay showsHorizontalScrollIndicator") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.showsHorizontalScrollIndicator,
                    keyPath: \.showsHorizontalScrollIndicator
                )
            }
            it("should relay scrollIndicatorInsets") {
                testInsetsRelay(
                    for: view,
                    relay: view.bindables.scrollIndicatorInsets,
                    keyPath: \.scrollIndicatorInsets
                )
            }
            it("should relay delaysContentTouches") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.delaysContentTouches,
                    keyPath: \.delaysContentTouches
                )
            }
            it("should relay canCancelContentTouches") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.canCancelContentTouches,
                    keyPath: \.canCancelContentTouches
                )
            }
            it("should relay minimumZoomScale") {
                testCGFloatRelay(
                    for: view,
                    relay: view.bindables.minimumZoomScale,
                    keyPath: \.minimumZoomScale
                )
            }
            it("should relay maximumZoomScale") {
                testCGFloatRelay(
                    for: view,
                    relay: view.bindables.maximumZoomScale,
                    keyPath: \.maximumZoomScale
                )
            }
            it("should relay bouncesZoom") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.bouncesZoom,
                    keyPath: \.bouncesZoom
                )
            }
            it("should relay scrollsToTop") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.scrollsToTop,
                    keyPath: \.scrollsToTop
                )
            }
            it("should relay refreshControl") {
                testRefreshRelay(
                    for: view,
                    relay: view.bindables.refreshControl,
                    keyPath: \.refreshControl
                )
            }
            it("should relay verticalScrollIndicatorInsets") {
                if #available(iOS 11.1, *) {
                    testInsetsRelay(
                        for: view,
                        relay: view.bindables.verticalScrollIndicatorInsets,
                        keyPath: \.verticalScrollIndicatorInsets
                    )
                }
            }
            it("should relay horizontalScrollIndicatorInsets") {
                if #available(iOS 11.1, *) {
                    testInsetsRelay(
                        for: view,
                        relay: view.bindables.horizontalScrollIndicatorInsets,
                        keyPath: \.horizontalScrollIndicatorInsets
                    )
                }
            }
        }
    }
}

extension UIScrollViewRelayCollectionSpec: UIScrollViewDelegate { }
#endif
