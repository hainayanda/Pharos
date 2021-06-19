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

class UITextViewRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UITextViewRelayCollection") {
            var view: UITextView!
            beforeEach {
                view = UITextView()
            }
            it("should relay text") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.text,
                    keyPath: \.text
                )
            }
            it("should relay font") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.font,
                    keyPath: \.font
                )
            }
            it("should relay textColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.textColor,
                    keyPath: \.textColor
                )
            }
            it("should relay selectedRange") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.selectedRange,
                    keyPath: \.selectedRange
                )
            }
            it("should relay isEditable") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isEditable,
                    keyPath: \.isEditable
                )
            }
            it("should relay isSelectable") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isSelectable,
                    keyPath: \.isSelectable
                )
            }
            it("should relay allowsEditingTextAttributes") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.allowsEditingTextAttributes,
                    keyPath: \.allowsEditingTextAttributes
                )
            }
            it("should relay attributedText") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.attributedText,
                    keyPath: \.attributedText
                )
            }
            it("should relay inputView") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.inputView,
                    keyPath: \.inputView
                )
            }
            it("should relay inputAccessoryView") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.inputAccessoryView,
                    keyPath: \.inputAccessoryView
                )
            }
            it("should relay clearsOnInsertion") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.clearsOnInsertion,
                    keyPath: \.clearsOnInsertion
                )
            }
            it("should relay textContainerInset") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.textContainerInset,
                    keyPath: \.textContainerInset
                )
            }
            it("should relay usesStandardTextScaling") {
                if #available(iOS 13.0, *) {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.usesStandardTextScaling,
                        keyPath: \.usesStandardTextScaling
                    )
                }
            }
            it("should relay delegate") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.delegate,
                    keyPath: \.delegate,
                    with: self
                ) { changes, oldValue in
                    expect(oldValue).to(beNil())
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
                testRelay(
                    for: view,
                    relay: view.bondableRelays.text,
                    keyPath: \.text
                )
            }
            it("should relay attributedText") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.attributedText,
                    keyPath: \.attributedText
                )
            }
            it("should relay textColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.textColor,
                    keyPath: \.textColor
                )
            }
            it("should relay font") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.font,
                    keyPath: \.font
                )
            }
            it("should relay placeholder") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.placeholder,
                    keyPath: \.placeholder
                )
            }
            it("should relay adjustsFontSizeToFitWidth") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.adjustsFontSizeToFitWidth,
                    keyPath: \.adjustsFontSizeToFitWidth
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
                    guard let spec = changes.new as? UITextFieldRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay disabledBackground") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.disabledBackground,
                    keyPath: \.disabledBackground
                )
            }
            it("should relay allowsEditingTextAttributes") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.allowsEditingTextAttributes,
                    keyPath: \.allowsEditingTextAttributes
                )
            }
            it("should relay leftView") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.leftView,
                    keyPath: \.leftView
                )
            }
            it("should relay rightViewMode") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.rightView,
                    keyPath: \.rightView
                )
            }
            it("should relay rightViewMode") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.rightView,
                    keyPath: \.rightView
                )
            }
            it("should relay inputView") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.inputView,
                    keyPath: \.inputView
                )
            }
            it("should relay inputAccessoryView") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.inputAccessoryView,
                    keyPath: \.inputAccessoryView
                )
            }
            it("should relay clearsOnInsertion") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.clearsOnInsertion,
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
                    relay: view.bondableRelays.delegate,
                    keyPath: \.delegate,
                    with: self
                ) { changes, oldValue in
                    expect(oldValue).to(beNil())
                    guard let spec = changes.new as? UISearchBarRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay text") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.text,
                    keyPath: \.text
                )
            }
            it("should relay prompt") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.prompt,
                    keyPath: \.prompt
                )
            }
            it("should relay placeholder") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.placeholder,
                    keyPath: \.placeholder
                )
            }
            it("should relay showsBookmarkButton") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.showsBookmarkButton,
                    keyPath: \.showsBookmarkButton
                )
            }
            it("should relay showsCancelButton") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.showsCancelButton,
                    keyPath: \.showsCancelButton
                )
            }
            it("should relay showsSearchResultsButton") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.showsSearchResultsButton,
                    keyPath: \.showsSearchResultsButton
                )
            }
            it("should relay isSearchResultsButtonSelected") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isSearchResultsButtonSelected,
                    keyPath: \.isSearchResultsButtonSelected
                )
            }
            it("should relay barTintColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.barTintColor,
                    keyPath: \.barTintColor
                )
            }
            it("should relay isTranslucent") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isTranslucent,
                    keyPath: \.isTranslucent
                )
            }
            it("should relay inputAccessoryView") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.inputAccessoryView,
                    keyPath: \.inputAccessoryView
                )
            }
            it("should relay backgroundImage") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.backgroundImage,
                    keyPath: \.backgroundImage
                )
            }
            it("should relay searchFieldBackgroundPositionAdjustment") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.searchFieldBackgroundPositionAdjustment,
                    keyPath: \.searchFieldBackgroundPositionAdjustment
                )
            }
            it("should relay searchTextPositionAdjustment") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.searchTextPositionAdjustment,
                    keyPath: \.searchTextPositionAdjustment
                )
            }
        }
    }
}

extension UISearchBarRelayCollectionSpec: UISearchBarDelegate { }
#endif
