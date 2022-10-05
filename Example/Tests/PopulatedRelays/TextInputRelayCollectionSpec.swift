//
//  TextInputRelayCollectionSpec.swift
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

class UITextViewRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UITextViewRelayCollection") {
            var view: UITextView!
            beforeEach {
                view = UITextView()
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
            it("should relay selectedRange") {
                testRangeRelay(
                    for: view,
                    relay: view.bindables.selectedRange,
                    keyPath: \.selectedRange
                )
            }
            it("should relay isEditable") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isEditable,
                    keyPath: \.isEditable
                )
            }
            it("should relay isSelectable") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isSelectable,
                    keyPath: \.isSelectable
                )
            }
            it("should relay allowsEditingTextAttributes") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.allowsEditingTextAttributes,
                    keyPath: \.allowsEditingTextAttributes
                )
            }
            it("should relay attributedText") {
                testAttributedStringRelay(
                    for: view,
                    relay: view.bindables.attributedText,
                    keyPath: \.attributedText
                )
            }
            it("should relay inputView") {
                testViewRelay(
                    for: view,
                    relay: view.bindables.inputView,
                    keyPath: \.inputView
                )
            }
            it("should relay inputAccessoryView") {
                testViewRelay(
                    for: view,
                    relay: view.bindables.inputAccessoryView,
                    keyPath: \.inputAccessoryView
                )
            }
            it("should relay clearsOnInsertion") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.clearsOnInsertion,
                    keyPath: \.clearsOnInsertion
                )
            }
            it("should relay textContainerInset") {
                testInsetsRelay(
                    for: view,
                    relay: view.bindables.textContainerInset,
                    keyPath: \.textContainerInset
                )
            }
            it("should relay usesStandardTextScaling") {
                if #available(iOS 13.0, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bindables.usesStandardTextScaling,
                        keyPath: \.usesStandardTextScaling
                    )
                }
            }
            it("should relay delegate") {
                testRelay(
                    for: view,
                    relay: view.bindables.delegate,
                    keyPath: \.delegate,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
                    guard let spec = changes.new as? UITextViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
        }
    }
}

extension UITextViewRelayCollectionSpec: UITextViewDelegate { }

class UITextFieldRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UITextViewRelayCollection") {
            var view: UITextField!
            beforeEach {
                view = UITextField()
            }
            it("should relay text") {
                testStringRelay(
                    for: view,
                    relay: view.bindables.text,
                    keyPath: \.text
                )
            }
            it("should relay attributedText") {
                testOptAttributedStringRelay(
                    for: view,
                    relay: view.bindables.attributedText,
                    keyPath: \.attributedText
                )
            }
            it("should relay textColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.textColor,
                    keyPath: \.textColor
                )
            }
            it("should relay font") {
                testFontRelay(
                    for: view,
                    relay: view.bindables.font,
                    keyPath: \.font
                )
            }
            it("should relay placeholder") {
                testStringRelay(
                    for: view,
                    relay: view.bindables.placeholder,
                    keyPath: \.placeholder
                )
            }
            it("should relay adjustsFontSizeToFitWidth") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.adjustsFontSizeToFitWidth,
                    keyPath: \.adjustsFontSizeToFitWidth
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
                    guard let spec = changes.new as? UITextFieldRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay disabledBackground") {
                testImageRelay(
                    for: view,
                    relay: view.bindables.disabledBackground,
                    keyPath: \.disabledBackground
                )
            }
            it("should relay allowsEditingTextAttributes") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.allowsEditingTextAttributes,
                    keyPath: \.allowsEditingTextAttributes
                )
            }
            it("should relay leftView") {
                testViewRelay(
                    for: view,
                    relay: view.bindables.leftView,
                    keyPath: \.leftView
                )
            }
            it("should relay rightViewMode") {
                testViewRelay(
                    for: view,
                    relay: view.bindables.rightView,
                    keyPath: \.rightView
                )
            }
            it("should relay inputView") {
                testViewRelay(
                    for: view,
                    relay: view.bindables.inputView,
                    keyPath: \.inputView
                )
            }
            it("should relay inputAccessoryView") {
                testViewRelay(
                    for: view,
                    relay: view.bindables.inputAccessoryView,
                    keyPath: \.inputAccessoryView
                )
            }
            it("should relay clearsOnInsertion") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.clearsOnInsertion,
                    keyPath: \.clearsOnInsertion
                )
            }
        }
    }
}

extension UITextFieldRelayCollectionSpec: UITextFieldDelegate { }

class UISearchBarRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UISearchBarRelayCollection") {
            var view: UISearchBar!
            beforeEach {
                view = UISearchBar()
            }
            it("should relay delegate") {
                testRelay(
                    for: view,
                    relay: view.bindables.delegate,
                    keyPath: \.delegate,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
                    guard let spec = changes.new as? UISearchBarRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay text") {
                testStringRelay(
                    for: view,
                    relay: view.bindables.text,
                    keyPath: \.text
                )
            }
            it("should relay prompt") {
                testStringRelay(
                    for: view,
                    relay: view.bindables.prompt,
                    keyPath: \.prompt
                )
            }
            it("should relay placeholder") {
                testStringRelay(
                    for: view,
                    relay: view.bindables.placeholder,
                    keyPath: \.placeholder
                )
            }
            it("should relay showsBookmarkButton") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.showsBookmarkButton,
                    keyPath: \.showsBookmarkButton
                )
            }
            it("should relay showsCancelButton") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.showsCancelButton,
                    keyPath: \.showsCancelButton
                )
            }
            it("should relay showsSearchResultsButton") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.showsSearchResultsButton,
                    keyPath: \.showsSearchResultsButton
                )
            }
            it("should relay isSearchResultsButtonSelected") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isSearchResultsButtonSelected,
                    keyPath: \.isSearchResultsButtonSelected
                )
            }
            it("should relay barTintColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.barTintColor,
                    keyPath: \.barTintColor
                )
            }
            it("should relay isTranslucent") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isTranslucent,
                    keyPath: \.isTranslucent
                )
            }
            it("should relay inputAccessoryView") {
                testViewRelay(
                    for: view,
                    relay: view.bindables.inputAccessoryView,
                    keyPath: \.inputAccessoryView
                )
            }
            it("should relay backgroundImage") {
                testImageRelay(
                    for: view,
                    relay: view.bindables.backgroundImage,
                    keyPath: \.backgroundImage
                )
            }
            it("should relay searchFieldBackgroundPositionAdjustment") {
                testOffsetRelay(
                    for: view,
                    relay: view.bindables.searchFieldBackgroundPositionAdjustment,
                    keyPath: \.searchFieldBackgroundPositionAdjustment
                )
            }
            it("should relay searchTextPositionAdjustment") {
                testOffsetRelay(
                    for: view,
                    relay: view.bindables.searchTextPositionAdjustment,
                    keyPath: \.searchTextPositionAdjustment
                )
            }
        }
    }
}

extension UISearchBarRelayCollectionSpec: UISearchBarDelegate { }
#endif
