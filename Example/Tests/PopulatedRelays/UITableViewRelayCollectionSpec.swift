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
                    relay: view.bondableRelays.delegate,
                    keyPath: \.delegate,
                    with: self
                ) { changes, oldValue in
                    expect(oldValue).to(beNil())
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
                    relay: view.bondableRelays.dataSource,
                    keyPath: \.dataSource,
                    with: self
                ) { changes, oldValue in
                    expect(oldValue).to(beNil())
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
                    relay: view.bondableRelays.prefetchDataSource,
                    keyPath: \.prefetchDataSource,
                    with: self
                ) { changes, oldValue in
                    expect(oldValue).to(beNil())
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
                    relay: view.bondableRelays.dragDelegate,
                    keyPath: \.dragDelegate,
                    with: self
                ) { changes, oldValue in
                    expect(oldValue).to(beNil())
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
                    relay: view.bondableRelays.dropDelegate,
                    keyPath: \.dropDelegate,
                    with: self
                ) { changes, oldValue in
                    expect(oldValue).to(beNil())
                    guard let spec = changes.new as? UITableViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay rowHeight") {
                let newValue = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bondableRelays.rowHeight,
                    keyPath: \.rowHeight,
                    with: newValue) { changes, oldValue in
                    expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
                    expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
                }
            }
            it("should relay sectionHeaderHeight") {
                let newValue = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bondableRelays.sectionHeaderHeight,
                    keyPath: \.sectionHeaderHeight,
                    with: newValue) { changes, oldValue in
                    expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
                    expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
                }
            }
            it("should relay sectionFooterHeight") {
                let newValue = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bondableRelays.sectionFooterHeight,
                    keyPath: \.sectionFooterHeight,
                    with: newValue) { changes, oldValue in
                    expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
                    expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
                }
            }
            it("should relay estimatedRowHeight") {
                let newValue = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bondableRelays.estimatedRowHeight,
                    keyPath: \.estimatedRowHeight,
                    with: newValue) { changes, oldValue in
                    expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
                    expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
                }
            }
            it("should relay estimatedSectionHeaderHeight") {
                let newValue = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bondableRelays.estimatedSectionHeaderHeight,
                    keyPath: \.estimatedSectionHeaderHeight,
                    with: newValue) { changes, oldValue in
                    expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
                    expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
                }
            }
            it("should relay estimatedSectionFooterHeight") {
                let newValue = CGFloat.random(in: 0..<1024)
                testRelay(
                    for: view,
                    relay: view.bondableRelays.estimatedSectionFooterHeight,
                    keyPath: \.estimatedSectionFooterHeight,
                    with: newValue) { changes, oldValue in
                    expect(abs(changes.new - newValue)).to(beLessThan(0.0001))
                    expect(abs(changes.old - oldValue)).to(beLessThan(0.0001))
                }
            }
            it("should relay separatorInset") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.separatorInset,
                    keyPath: \.separatorInset
                )
            }
            it("should relay dragInteractionEnabled") {
                if #available(iOS 11.0, *) {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.dragInteractionEnabled,
                        keyPath: \.dragInteractionEnabled
                    )
                }
            }
            it("should relay backgroundView") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.backgroundView,
                    keyPath: \.backgroundView
                )
            }
            it("should relay allowsSelection") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.allowsSelection,
                    keyPath: \.allowsSelection
                )
            }
            it("should relay allowsMultipleSelection") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.allowsMultipleSelection,
                    keyPath: \.allowsMultipleSelection
                )
            }
            it("should relay remembersLastFocusedIndexPath") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.remembersLastFocusedIndexPath,
                    keyPath: \.remembersLastFocusedIndexPath
                )
            }
            it("should relay selectionFollowsFocus") {
                if #available(iOS 14.0, *) {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.selectionFollowsFocus,
                        keyPath: \.selectionFollowsFocus
                    )
                }
            }
            it("should relay isEditing") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isEditing,
                    keyPath: \.isEditing
                )
            }
            it("should relay sectionIndexMinimumDisplayRowCount") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.sectionIndexMinimumDisplayRowCount,
                    keyPath: \.sectionIndexMinimumDisplayRowCount
                )
            }
            it("should relay sectionIndexColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.sectionIndexColor,
                    keyPath: \.sectionIndexColor
                )
            }
            it("should relay sectionIndexBackgroundColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.sectionIndexBackgroundColor,
                    keyPath: \.sectionIndexBackgroundColor
                )
            }
            it("should relay sectionIndexTrackingBackgroundColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.sectionIndexTrackingBackgroundColor,
                    keyPath: \.sectionIndexTrackingBackgroundColor
                )
            }
            it("should relay sectionIndexTrackingBackgroundColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.sectionIndexTrackingBackgroundColor,
                    keyPath: \.sectionIndexTrackingBackgroundColor
                )
            }
            it("should relay separatorColor") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.separatorColor,
                    keyPath: \.separatorColor
                )
            }
            it("should relay separatorEffect") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.separatorEffect,
                    keyPath: \.separatorEffect
                )
            }
            it("should relay cellLayoutMarginsFollowReadableWidth") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.cellLayoutMarginsFollowReadableWidth,
                    keyPath: \.cellLayoutMarginsFollowReadableWidth
                )
            }
            it("should relay insetsContentViewsToSafeArea") {
                if #available(iOS 11.0, *) {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.insetsContentViewsToSafeArea,
                        keyPath: \.insetsContentViewsToSafeArea
                    )
                }
            }
            it("should relay tableHeaderView") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.tableHeaderView,
                    keyPath: \.tableHeaderView
                )
            }
            it("should relay tableFooterView") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.tableFooterView,
                    keyPath: \.tableFooterView
                )
            }
            it("should relay remembersLastFocusedIndexPath") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.remembersLastFocusedIndexPath,
                    keyPath: \.remembersLastFocusedIndexPath
                )
            }
            it("should relay insetsContentViewsToSafeArea") {
                if #available(iOS 14.0, *) {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.selectionFollowsFocus,
                        keyPath: \.selectionFollowsFocus
                    )
                }
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
