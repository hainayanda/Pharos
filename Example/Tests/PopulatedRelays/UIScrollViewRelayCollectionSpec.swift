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

class UIScrollViewRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UIScrollViewRelayCollection") {
            var view: UIScrollView!
            beforeEach {
                view = UIScrollView()
            }
            it("should relay contentSize") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.contentSize,
                    keyPath: \.contentSize
                )
            }
            it("should relay contentInset") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.contentInset,
                    keyPath: \.contentInset
                )
            }
            it("should relay delegate") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.delegate,
                    keyPath: \.delegate,
                    with: self
                ) { changes, oldValue in
                    expect(oldValue).to(beNil())
                    guard let spec = changes.new as? UIScrollViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay isDirectionalLockEnabled") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isDirectionalLockEnabled,
                    keyPath: \.isDirectionalLockEnabled
                )
            }
            it("should relay bounces") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.bounces,
                    keyPath: \.bounces
                )
            }
            it("should relay alwaysBounceVertical") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.alwaysBounceVertical,
                    keyPath: \.alwaysBounceVertical
                )
            }
            it("should relay alwaysBounceHorizontal") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.alwaysBounceHorizontal,
                    keyPath: \.alwaysBounceHorizontal
                )
            }
            it("should relay isPagingEnabled") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isPagingEnabled,
                    keyPath: \.isPagingEnabled
                )
            }
            it("should relay isUserInteractionEnabled") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isUserInteractionEnabled,
                    keyPath: \.isUserInteractionEnabled
                )
            }
            it("should relay isScrollEnabled") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isScrollEnabled,
                    keyPath: \.isScrollEnabled
                )
            }
            it("should relay showsVerticalScrollIndicator") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.showsVerticalScrollIndicator,
                    keyPath: \.showsVerticalScrollIndicator
                )
            }
            it("should relay showsHorizontalScrollIndicator") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.showsHorizontalScrollIndicator,
                    keyPath: \.showsHorizontalScrollIndicator
                )
            }
            it("should relay scrollIndicatorInsets") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.scrollIndicatorInsets,
                    keyPath: \.scrollIndicatorInsets
                )
            }
            it("should relay delaysContentTouches") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.delaysContentTouches,
                    keyPath: \.delaysContentTouches
                )
            }
            it("should relay canCancelContentTouches") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.canCancelContentTouches,
                    keyPath: \.canCancelContentTouches
                )
            }
            it("should relay minimumZoomScale") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.minimumZoomScale,
                    keyPath: \.minimumZoomScale
                )
            }
            it("should relay maximumZoomScale") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.maximumZoomScale,
                    keyPath: \.maximumZoomScale
                )
            }
            it("should relay bouncesZoom") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.bouncesZoom,
                    keyPath: \.bouncesZoom
                )
            }
            it("should relay scrollsToTop") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.scrollsToTop,
                    keyPath: \.scrollsToTop
                )
            }
            it("should relay refreshControl") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.refreshControl,
                    keyPath: \.refreshControl
                )
            }
            it("should relay verticalScrollIndicatorInsets") {
                if #available(iOS 11.1, *) {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.verticalScrollIndicatorInsets,
                        keyPath: \.verticalScrollIndicatorInsets
                    )
                }
            }
            it("should relay horizontalScrollIndicatorInsets") {
                if #available(iOS 11.1, *) {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.horizontalScrollIndicatorInsets,
                        keyPath: \.horizontalScrollIndicatorInsets
                    )
                }
            }
        }
    }
}

extension UIScrollViewRelayCollectionSpec: UIScrollViewDelegate { }
#endif
