//
//  CellInputRelayCollectionSpec.swift
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

class TableCellInputRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("TableCellInputRelayCollection") {
            var view: UITableViewCell!
            beforeEach {
                view = UITableViewCell()
            }
            it("should relay automaticallyUpdatesContentConfiguration") {
                if #available(iOS 14.0, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bondableRelays.automaticallyUpdatesContentConfiguration,
                        keyPath: \.automaticallyUpdatesContentConfiguration
                    )
                }
            }
            it("should relay automaticallyUpdatesBackgroundConfiguration") {
                if #available(iOS 14.0, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bondableRelays.automaticallyUpdatesBackgroundConfiguration,
                        keyPath: \.automaticallyUpdatesBackgroundConfiguration
                    )
                }
            }
            it("should relay backgroundView") {
                testViewRelay(
                    for: view,
                    relay: view.bondableRelays.backgroundView,
                    keyPath: \.backgroundView
                )
            }
            it("should relay selectedBackgroundView") {
                testViewRelay(
                    for: view,
                    relay: view.bondableRelays.selectedBackgroundView,
                    keyPath: \.selectedBackgroundView
                )
            }
            it("should relay multipleSelectionBackgroundView") {
                testViewRelay(
                    for: view,
                    relay: view.bondableRelays.multipleSelectionBackgroundView,
                    keyPath: \.multipleSelectionBackgroundView
                )
            }
            it("should relay isSelected") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.isSelected,
                    keyPath: \.isSelected
                )
            }
            it("should relay isHighlighted") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.isHighlighted,
                    keyPath: \.isHighlighted
                )
            }
            it("should relay showsReorderControl") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.showsReorderControl,
                    keyPath: \.showsReorderControl
                )
            }
            it("should relay shouldIndentWhileEditing") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.shouldIndentWhileEditing,
                    keyPath: \.shouldIndentWhileEditing
                )
            }
            it("should relay accessoryView") {
                testViewRelay(
                    for: view,
                    relay: view.bondableRelays.accessoryView,
                    keyPath: \.accessoryView
                )
            }
            it("should relay indentationLevel") {
                testIntRelay(
                    for: view,
                    relay: view.bondableRelays.indentationLevel,
                    keyPath: \.indentationLevel
                )
            }
            it("should relay indentationWidth") {
                testCGFloatRelay(
                    for: view,
                    relay: view.bondableRelays.indentationWidth,
                    keyPath: \.indentationWidth
                )
            }
            it("should relay isEditing") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.isEditing,
                    keyPath: \.isEditing
                )
            }
            it("should relay userInteractionEnabledWhileDragging") {
                if #available(iOS 11.0, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bondableRelays.userInteractionEnabledWhileDragging,
                        keyPath: \.userInteractionEnabledWhileDragging
                    )
                }
            }
        }
    }
}

class CollectionCellInputRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("CollectionCellInputRelayCollection") {
            var view: UICollectionViewCell!
            beforeEach {
                view = UICollectionViewCell()
            }
            it("should relay automaticallyUpdatesContentConfiguration") {
                if #available(iOS 14.0, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bondableRelays.automaticallyUpdatesContentConfiguration,
                        keyPath: \.automaticallyUpdatesContentConfiguration
                    )
                }
            }
            it("should relay automaticallyUpdatesBackgroundConfiguration") {
                if #available(iOS 14.0, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bondableRelays.automaticallyUpdatesBackgroundConfiguration,
                        keyPath: \.automaticallyUpdatesBackgroundConfiguration
                    )
                }
            }
            it("should relay backgroundView") {
                testViewRelay(
                    for: view,
                    relay: view.bondableRelays.backgroundView,
                    keyPath: \.backgroundView
                )
            }
            it("should relay selectedBackgroundView") {
                testViewRelay(
                    for: view,
                    relay: view.bondableRelays.selectedBackgroundView,
                    keyPath: \.selectedBackgroundView
                )
            }
            it("should relay isSelected") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.isSelected,
                    keyPath: \.isSelected
                )
            }
            it("should relay isHighlighted") {
                testBoolRelay(
                    for: view,
                    relay: view.bondableRelays.isHighlighted,
                    keyPath: \.isHighlighted
                )
            }
        }
    }
}
#endif
