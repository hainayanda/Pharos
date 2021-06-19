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
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isEnabled,
                    keyPath: \.isEnabled
                )
            }
            it("should relay isSelected") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isSelected,
                    keyPath: \.isSelected
                )
            }
            it("should relay isHighlighted") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isHighlighted,
                    keyPath: \.isHighlighted
                )
            }
        }
    }
}
#endif
