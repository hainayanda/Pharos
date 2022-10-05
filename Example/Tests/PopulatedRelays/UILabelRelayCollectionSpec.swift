//
//  UILabelRelayCollectionSpec.swift
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

class UILabelRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UILabelRelayCollection") {
            var view: UILabel!
            beforeEach {
                view = UILabel()
            }
            it("should relay text") {
                testStringRelay(
                    for: view,
                    relay: view.bindables.text,
                    keyPath: \.text
                )
            }
            it("should relay font") {
                testFontRelay(
                    for: view,
                    relay: view.bindables.font,
                    keyPath: \.font
                )
            }
            it("should relay textColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.textColor,
                    keyPath: \.textColor
                )
            }
            it("should relay shadowColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.shadowColor,
                    keyPath: \.shadowColor
                )
            }
            it("should relay shadowOffset") {
                testSizeRelay(
                    for: view,
                    relay: view.bindables.shadowOffset,
                    keyPath: \.shadowOffset
                )
            }
            it("should relay attributedText") {
                testOptAttributedStringRelay(
                    for: view,
                    relay: view.bindables.attributedText,
                    keyPath: \.attributedText
                )
            }
            it("should relay highlightedTextColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.highlightedTextColor,
                    keyPath: \.highlightedTextColor
                )
            }
            it("should relay isHighlighted") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isHighlighted,
                    keyPath: \.isHighlighted
                )
            }
            it("should relay isUserInteractionEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isUserInteractionEnabled,
                    keyPath: \.isUserInteractionEnabled
                )
            }
            it("should relay isEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isEnabled,
                    keyPath: \.isEnabled
                )
            }
            it("should relay numberOfLines") {
                testIntRelay(
                    for: view,
                    relay: view.bindables.numberOfLines,
                    keyPath: \.numberOfLines
                )
            }
            it("should relay adjustsFontSizeToFitWidth") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.adjustsFontSizeToFitWidth,
                    keyPath: \.adjustsFontSizeToFitWidth
                )
            }
            it("should relay allowsDefaultTighteningForTruncation") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.allowsDefaultTighteningForTruncation,
                    keyPath: \.allowsDefaultTighteningForTruncation
                )
            }
            it("should relay preferredMaxLayoutWidth") {
                testCGFloatRelay(
                    for: view,
                    relay: view.bindables.preferredMaxLayoutWidth,
                    keyPath: \.preferredMaxLayoutWidth
                )
            }
        }
    }
}
#endif
