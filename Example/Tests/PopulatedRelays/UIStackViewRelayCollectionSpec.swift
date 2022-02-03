//
//  UIStackViewRelayCollectionSpec.swift
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

class UIStackViewRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UIStackViewRelayCollection") {
            var view: UIStackView!
            beforeEach {
                view = UIStackView()
            }
            it("should relay spacing") {
                testCGFloatRelay(
                    for: view,
                    relay: view.bindables.spacing,
                    keyPath: \.spacing
                )
            }
            it("should relay isBaselineRelativeArrangement") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isBaselineRelativeArrangement,
                    keyPath: \.isBaselineRelativeArrangement
                )
            }
            it("should relay isLayoutMarginsRelativeArrangement") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isLayoutMarginsRelativeArrangement,
                    keyPath: \.isLayoutMarginsRelativeArrangement
                )
            }
        }
    }
}
#endif
