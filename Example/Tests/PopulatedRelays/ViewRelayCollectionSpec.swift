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
                        relay: view.bondableRelays.isUserInteractionEnabled,
                        keyPath: \.isUserInteractionEnabled
                    )
                }
                it("should relay tag") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.tag,
                        keyPath: \.tag
                    )
                }
                it("should relay focusGroupIdentifier") {
                    if #available(iOS 14, *) {
                        testRelay(
                            for: view,
                            relay: view.bondableRelays.focusGroupIdentifier,
                            keyPath: \.focusGroupIdentifier
                        )
                    }
                }
                it("should relay frame") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.frame,
                        keyPath: \.frame
                    )
                }
                it("should relay bounds") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.bounds,
                        keyPath: \.bounds
                    )
                }
                it("should relay center") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.center,
                        keyPath: \.center
                    )
                }
                it("should relay contentScaleFactor") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.contentScaleFactor,
                        keyPath: \.contentScaleFactor
                    )
                }
                it("should relay isMultipleTouchEnabled") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.isMultipleTouchEnabled,
                        keyPath: \.isMultipleTouchEnabled
                    )
                }
                it("should relay isExclusiveTouch") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.isExclusiveTouch,
                        keyPath: \.isExclusiveTouch
                    )
                }
                it("should relay autoresizesSubviews") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.autoresizesSubviews,
                        keyPath: \.autoresizesSubviews
                    )
                }
                it("should relay layoutMargins") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.layoutMargins,
                        keyPath: \.layoutMargins
                    )
                }
                it("should relay directionalLayoutMargins") {
                    if #available(iOS 11, *) {
                        testRelay(
                            for: view,
                            relay: view.bondableRelays.directionalLayoutMargins,
                            keyPath: \.directionalLayoutMargins
                        )
                    }
                }
                it("should relay insetsLayoutMarginsFromSafeArea") {
                    if #available(iOS 11, *) {
                        testRelay(
                            for: view,
                            relay: view.bondableRelays.insetsLayoutMarginsFromSafeArea,
                            keyPath: \.insetsLayoutMarginsFromSafeArea
                        )
                    }
                }
                it("should relay preservesSuperviewLayoutMargins") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.preservesSuperviewLayoutMargins,
                        keyPath: \.preservesSuperviewLayoutMargins
                    )
                }
                it("should relay clipsToBounds") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.clipsToBounds,
                        keyPath: \.clipsToBounds
                    )
                }
                it("should relay backgroundColor") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.backgroundColor,
                        keyPath: \.backgroundColor
                    )
                }
                it("should relay alpha") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.alpha,
                        keyPath: \.alpha
                    )
                }
                it("should relay isOpaque") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.isOpaque,
                        keyPath: \.isOpaque
                    )
                }
                it("should relay clearsContextBeforeDrawing") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.clearsContextBeforeDrawing,
                        keyPath: \.clearsContextBeforeDrawing
                    )
                }
                it("should relay isHidden") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.isHidden,
                        keyPath: \.isHidden
                    )
                }
                it("should relay mask") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.mask,
                        keyPath: \.mask
                    )
                }
                it("should relay tintColor") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.tintColor,
                        keyPath: \.tintColor
                    )
                }
                it("should relay translatesAutoresizingMaskIntoConstraints") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.translatesAutoresizingMaskIntoConstraints,
                        keyPath: \.translatesAutoresizingMaskIntoConstraints
                    )
                }
                it("should relay restorationIdentifier") {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.restorationIdentifier,
                        keyPath: \.restorationIdentifier
                    )
                }
            }
        }
    }
}
#endif
