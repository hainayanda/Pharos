//
//  ViewRelayCollectionSpec.swift
//  Pharos_Tests
//
//  Created by Nayanda Haberty on 13/06/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Pharos
#if canImport(UIKit)
import UIKit

class ViewRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("ViewRelayCollection") {
            var view: UIView!
            beforeEach {
                view = UIView()
            }
            context("TwoWayRelay") {
                it("should relay isUserInteractionEnabled") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.isUserInteractionEnabled,
                        keyPath: \.isUserInteractionEnabled
                    )
                }
                it("should relay tag") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.tag,
                        keyPath: \.tag
                    )
                }
                it("should relay focusGroupIdentifier") {
                    if #available(iOS 14, *) {
                        testRelay(
                            for: view,
                            relay: view.viewRelays.focusGroupIdentifier,
                            keyPath: \.focusGroupIdentifier
                        )
                    }
                }
                it("should relay frame") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.frame,
                        keyPath: \.frame
                    )
                }
                it("should relay bounds") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.bounds,
                        keyPath: \.bounds
                    )
                }
                it("should relay center") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.center,
                        keyPath: \.center
                    )
                }
                it("should relay contentScaleFactor") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.contentScaleFactor,
                        keyPath: \.contentScaleFactor
                    )
                }
                it("should relay isMultipleTouchEnabled") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.isMultipleTouchEnabled,
                        keyPath: \.isMultipleTouchEnabled
                    )
                }
                it("should relay isExclusiveTouch") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.isExclusiveTouch,
                        keyPath: \.isExclusiveTouch
                    )
                }
                it("should relay autoresizesSubviews") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.autoresizesSubviews,
                        keyPath: \.autoresizesSubviews
                    )
                }
                it("should relay layoutMargins") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.layoutMargins,
                        keyPath: \.layoutMargins
                    )
                }
                it("should relay directionalLayoutMargins") {
                    if #available(iOS 11, *) {
                        testRelay(
                            for: view,
                            relay: view.viewRelays.directionalLayoutMargins,
                            keyPath: \.directionalLayoutMargins
                        )
                    }
                }
                it("should relay insetsLayoutMarginsFromSafeArea") {
                    if #available(iOS 11, *) {
                        testRelay(
                            for: view,
                            relay: view.viewRelays.insetsLayoutMarginsFromSafeArea,
                            keyPath: \.insetsLayoutMarginsFromSafeArea
                        )
                    }
                }
                it("should relay preservesSuperviewLayoutMargins") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.preservesSuperviewLayoutMargins,
                        keyPath: \.preservesSuperviewLayoutMargins
                    )
                }
                it("should relay clipsToBounds") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.clipsToBounds,
                        keyPath: \.clipsToBounds
                    )
                }
                it("should relay backgroundColor") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.backgroundColor,
                        keyPath: \.backgroundColor
                    )
                }
                it("should relay alpha") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.alpha,
                        keyPath: \.alpha
                    )
                }
                it("should relay isOpaque") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.isOpaque,
                        keyPath: \.isOpaque
                    )
                }
                it("should relay clearsContextBeforeDrawing") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.clearsContextBeforeDrawing,
                        keyPath: \.clearsContextBeforeDrawing
                    )
                }
                it("should relay isHidden") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.isHidden,
                        keyPath: \.isHidden
                    )
                }
                it("should relay mask") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.mask,
                        keyPath: \.mask
                    )
                }
                it("should relay tintColor") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.tintColor,
                        keyPath: \.tintColor
                    )
                }
                it("should relay translatesAutoresizingMaskIntoConstraints") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.translatesAutoresizingMaskIntoConstraints,
                        keyPath: \.translatesAutoresizingMaskIntoConstraints
                    )
                }
                it("should relay restorationIdentifier") {
                    testRelay(
                        for: view,
                        relay: view.viewRelays.restorationIdentifier,
                        keyPath: \.restorationIdentifier
                    )
                }
            }
        }
    }
}
#endif
