//
//  UIControlRelayCollectionSpec.swift
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

class UIControlRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UIControlRelayCollection") {
            var view: UIControl!
            beforeEach {
                view = UIControl()
            }
            it("should relay isEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isEnabled,
                    keyPath: \.isEnabled
                )
            }
            it("should relay isSelected") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isSelected,
                    keyPath: \.isSelected
                )
            }
            it("should relay isHighlighted") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isHighlighted,
                    keyPath: \.isHighlighted
                )
            }
        }
    }
}
#endif
