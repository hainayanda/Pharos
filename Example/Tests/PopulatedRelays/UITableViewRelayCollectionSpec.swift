//
//  UITableViewRelayCollectionSpec.swift
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
// swiftlint:disable function_body_length type_body_length

class UITableViewRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UITableViewRelayCollection") {
            var view: UITableView!
            beforeEach {
                view = UITableView()
            }
            it("should relay delegate") {
                testRelay(
                    for: view,
                    relay: view.bindables.delegate,
                    keyPath: \.delegate,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
                    guard let spec = changes.new as? UITableViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay dataSource") {
                testRelay(
                    for: view,
                    relay: view.bindables.dataSource,
                    keyPath: \.dataSource,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
                    guard let spec = changes.new as? UITableViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay prefetchDataSource") {
                testRelay(
                    for: view,
                    relay: view.bindables.prefetchDataSource,
                    keyPath: \.prefetchDataSource,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
                    guard let spec = changes.new as? UITableViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay dragDelegate") {
                guard #available(iOS 11, *) else { return }
                testRelay(
                    for: view,
                    relay: view.bindables.dragDelegate,
                    keyPath: \.dragDelegate,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
                    guard let spec = changes.new as? UITableViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay dropDelegate") {
                guard #available(iOS 11, *) else { return }
                testRelay(
                    for: view,
                    relay: view.bindables.dropDelegate,
                    keyPath: \.dropDelegate,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
                    guard let spec = changes.new as? UITableViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay rowHeight") {
                let new = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bindables.rowHeight,
                    keyPath: \.rowHeight,
                    with: new) { changes, old in
                    expect(abs(changes.new - new)).to(beLessThan(0.0001))
                    expect(abs(changes.old - old)).to(beLessThan(0.0001))
                }
            }
            it("should relay sectionHeaderHeight") {
                let new = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bindables.sectionHeaderHeight,
                    keyPath: \.sectionHeaderHeight,
                    with: new) { changes, old in
                    expect(abs(changes.new - new)).to(beLessThan(0.0001))
                    expect(abs(changes.old - old)).to(beLessThan(0.0001))
                }
            }
            it("should relay sectionFooterHeight") {
                let new = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bindables.sectionFooterHeight,
                    keyPath: \.sectionFooterHeight,
                    with: new) { changes, old in
                    expect(abs(changes.new - new)).to(beLessThan(0.0001))
                    expect(abs(changes.old - old)).to(beLessThan(0.0001))
                }
            }
            it("should relay estimatedRowHeight") {
                let new = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bindables.estimatedRowHeight,
                    keyPath: \.estimatedRowHeight,
                    with: new) { changes, old in
                    expect(abs(changes.new - new)).to(beLessThan(0.0001))
                    expect(abs(changes.old - old)).to(beLessThan(0.0001))
                }
            }
            it("should relay estimatedSectionHeaderHeight") {
                let new = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bindables.estimatedSectionHeaderHeight,
                    keyPath: \.estimatedSectionHeaderHeight,
                    with: new) { changes, old in
                    expect(abs(changes.new - new)).to(beLessThan(0.0001))
                    expect(abs(changes.old - old)).to(beLessThan(0.0001))
                }
            }
            it("should relay estimatedSectionFooterHeight") {
                let new = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bindables.estimatedSectionFooterHeight,
                    keyPath: \.estimatedSectionFooterHeight,
                    with: new) { changes, old in
                    expect(abs(changes.new - new)).to(beLessThan(0.0001))
                    expect(abs(changes.old - old)).to(beLessThan(0.0001))
                }
            }
            it("should relay separatorInset") {
                testInsetsRelay(
                    for: view,
                    relay: view.bindables.separatorInset,
                    keyPath: \.separatorInset
                )
            }
            it("should relay dragInteractionEnabled") {
                if #available(iOS 11.0, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bindables.dragInteractionEnabled,
                        keyPath: \.dragInteractionEnabled
                    )
                }
            }
            it("should relay backgroundView") {
                testViewRelay(
                    for: view,
                    relay: view.bindables.backgroundView,
                    keyPath: \.backgroundView
                )
            }
            it("should relay allowsSelection") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.allowsSelection,
                    keyPath: \.allowsSelection
                )
            }
            it("should relay allowsMultipleSelection") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.allowsMultipleSelection,
                    keyPath: \.allowsMultipleSelection
                )
            }
            it("should relay remembersLastFocusedIndexPath") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.remembersLastFocusedIndexPath,
                    keyPath: \.remembersLastFocusedIndexPath
                )
            }
            it("should relay selectionFollowsFocus") {
                if #available(iOS 14.0, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bindables.selectionFollowsFocus,
                        keyPath: \.selectionFollowsFocus
                    )
                }
            }
            it("should relay isEditing") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isEditing,
                    keyPath: \.isEditing
                )
            }
            it("should relay sectionIndexMinimumDisplayRowCount") {
                testIntRelay(
                    for: view,
                    relay: view.bindables.sectionIndexMinimumDisplayRowCount,
                    keyPath: \.sectionIndexMinimumDisplayRowCount
                )
            }
            it("should relay sectionIndexColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.sectionIndexColor,
                    keyPath: \.sectionIndexColor
                )
            }
            it("should relay sectionIndexBackgroundColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.sectionIndexBackgroundColor,
                    keyPath: \.sectionIndexBackgroundColor
                )
            }
            it("should relay sectionIndexTrackingBackgroundColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.sectionIndexTrackingBackgroundColor,
                    keyPath: \.sectionIndexTrackingBackgroundColor
                )
            }
            it("should relay sectionIndexTrackingBackgroundColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.sectionIndexTrackingBackgroundColor,
                    keyPath: \.sectionIndexTrackingBackgroundColor
                )
            }
            it("should relay separatorColor") {
                testColorRelay(
                    for: view,
                    relay: view.bindables.separatorColor,
                    keyPath: \.separatorColor
                )
            }
            it("should relay separatorEffect") {
                testVisualEffectRelay(
                    for: view,
                    relay: view.bindables.separatorEffect,
                    keyPath: \.separatorEffect
                )
            }
            it("should relay cellLayoutMarginsFollowReadableWidth") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.cellLayoutMarginsFollowReadableWidth,
                    keyPath: \.cellLayoutMarginsFollowReadableWidth
                )
            }
            it("should relay insetsContentViewsToSafeArea") {
                if #available(iOS 11.0, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bindables.insetsContentViewsToSafeArea,
                        keyPath: \.insetsContentViewsToSafeArea
                    )
                }
            }
            it("should relay tableHeaderView") {
                testViewRelay(
                    for: view,
                    relay: view.bindables.tableHeaderView,
                    keyPath: \.tableHeaderView
                )
            }
            it("should relay tableFooterView") {
                testViewRelay(
                    for: view,
                    relay: view.bindables.tableFooterView,
                    keyPath: \.tableFooterView
                )
            }
        }
    }
}

extension UITableViewRelayCollectionSpec:
    UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) { }
    
}

@available(iOS 11.0, *)
extension UITableViewRelayCollectionSpec: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        []
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }
    
}
#endif
