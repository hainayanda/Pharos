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
            it("should relay isUserInteractionEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isUserInteractionEnabled,
                    keyPath: \.isUserInteractionEnabled
                )
            }
            it("should relay tag") {
                testIntRelay(
                    for: view,
                    relay: view.bindables.tag,
                    keyPath: \.tag
                )
            }
            it("should relay focusGroupIdentifier") {
                if #available(iOS 14, *) {
                    testStringRelay(
                        for: view,
                        relay: view.bindables.focusGroupIdentifier,
                        keyPath: \.focusGroupIdentifier
                    )
                }
            }
            it("should relay frame") {
                testCGRectRelay(
                    for: view,
                    relay: view.bindables.frame,
                    keyPath: \.frame
                )
            }
            it("should relay bounds") {
                testCGRectRelay(
                    for: view,
                    relay: view.bindables.bounds,
                    keyPath: \.bounds
                )
            }
            it("should relay center") {
                testCGPointRelay(
                    for: view,
                    relay: view.bindables.center,
                    keyPath: \.center
                )
            }
            it("should relay contentScaleFactor") {
                testCGFloatRelay(
                    for: view,
                    relay: view.bindables.contentScaleFactor,
                    keyPath: \.contentScaleFactor
                )
            }
            it("should relay isMultipleTouchEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isMultipleTouchEnabled,
                    keyPath: \.isMultipleTouchEnabled
                )
            }
            it("should relay isExclusiveTouch") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isExclusiveTouch,
                    keyPath: \.isExclusiveTouch
                )
            }
            it("should relay autoresizesSubviews") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.autoresizesSubviews,
                    keyPath: \.autoresizesSubviews
                )
            }
            it("should relay layoutMargins") {
                testInsetsRelay(
                    for: view,
                    relay: view.bindables.layoutMargins,
                    keyPath: \.layoutMargins
                )
            }
            it("should relay directionalLayoutMargins") {
                if #available(iOS 11, *) {
                    testDirectionalInsetsRelay(
                        for: view,
                        relay: view.bindables.directionalLayoutMargins,
                        keyPath: \.directionalLayoutMargins
                    )
                }
            }
            it("should relay insetsLayoutMarginsFromSafeArea") {
                if #available(iOS 11, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bindables.insetsLayoutMarginsFromSafeArea,
                        keyPath: \.insetsLayoutMarginsFromSafeArea
                    )
                }
            }
            it("should relay preservesSuperviewLayoutMargins") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.preservesSuperviewLayoutMargins,
                    keyPath: \.preservesSuperviewLayoutMargins
                )
            }
            it("should relay clipsToBounds") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.clipsToBounds,
                    keyPath: \.clipsToBounds
                )
            }
            it("should relay backgroundColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.backgroundColor,
                    keyPath: \.backgroundColor
                )
            }
            it("should relay alpha") {
                testCGFloatRelay(
                    for: view,
                    relay: view.bindables.alpha,
                    keyPath: \.alpha
                )
            }
            it("should relay isOpaque") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isOpaque,
                    keyPath: \.isOpaque
                )
            }
            it("should relay clearsContextBeforeDrawing") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.clearsContextBeforeDrawing,
                    keyPath: \.clearsContextBeforeDrawing
                )
            }
            it("should relay isHidden") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isHidden,
                    keyPath: \.isHidden
                )
            }
            it("should relay mask") {
                testViewRelay(
                    for: view,
                    relay: view.bindables.mask,
                    keyPath: \.mask
                )
            }
            it("should relay tintColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.tintColor,
                    keyPath: \.tintColor
                )
            }
            it("should relay translatesAutoresizingMaskIntoConstraints") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.translatesAutoresizingMaskIntoConstraints,
                    keyPath: \.translatesAutoresizingMaskIntoConstraints
                )
            }
            it("should relay restorationIdentifier") {
                testStringRelay(
                    for: view,
                    relay: view.bindables.restorationIdentifier,
                    keyPath: \.restorationIdentifier
                )
            }
        }
    }
}
#endif
