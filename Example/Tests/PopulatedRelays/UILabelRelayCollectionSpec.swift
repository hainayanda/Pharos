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
                    relay: view.bondableRelays.text,
                    keyPath: \.text
                )
            }
            it("should relay font") {
                testFontRelay(
                    for: view,
                    relay: view.bondableRelays.font,
                    keyPath: \.font
                )
            }
            it("should relay textColor") {
                testColorRelay(
                    for: view,
                    relay: view.bondableRelays.textColor,
                    keyPath: \.textColor
                )
            }
            it("should relay shadowColor") {
                testColorRelay(
                    for: view,
                    relay: view.bondableRelays.shadowColor,
                    keyPath: \.shadowColor
                )
            }
            it("should relay shadowOffset") {
                testSizeRelay(
                    for: view,
                    relay: view.bondableRelays.shadowOffset,
                    keyPath: \.shadowOffset
                )
            }
            it("should relay attributedText") {
                testOptAttributedStringRelay(
                    for: view,
                    relay: view.bondableRelays.attributedText,
                    keyPath: \.attributedText
                )
            }
            it("should relay highlightedTextColor") {
                testColorRelay(
                    for: view,
                    relay: view.bondableRelays.highlightedTextColor,
                    keyPath: \.highlightedTextColor
                )
            }
            it("should relay isHighlighted") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.isHighlighted,
                    keyPath: \.isHighlighted
                )
            }
            it("should relay isUserInteractionEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.isUserInteractionEnabled,
                    keyPath: \.isUserInteractionEnabled
                )
            }
            it("should relay isEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.isEnabled,
                    keyPath: \.isEnabled
                )
            }
            it("should relay numberOfLines") {
                testIntRelay(
                    for: view,
                    relay: view.bondableRelays.numberOfLines,
                    keyPath: \.numberOfLines
                )
            }
            it("should relay adjustsFontSizeToFitWidth") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.adjustsFontSizeToFitWidth,
                    keyPath: \.adjustsFontSizeToFitWidth
                )
            }
            it("should relay allowsDefaultTighteningForTruncation") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.allowsDefaultTighteningForTruncation,
                    keyPath: \.allowsDefaultTighteningForTruncation
                )
            }
            it("should relay preferredMaxLayoutWidth") {
                testCGFloatRelay(
                    for: view,
                    relay: view.bondableRelays.preferredMaxLayoutWidth,
                    keyPath: \.preferredMaxLayoutWidth
                )
            }
        }
    }
}
#endif
