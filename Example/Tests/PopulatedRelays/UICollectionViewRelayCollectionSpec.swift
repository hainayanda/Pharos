//
//  UICollectionViewRelayCollectionSpec.swift
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

class UICollectionViewRelayCollectionSpec: QuickSpec {
    override func spec() {
        describe("UICollectionViewRelayCollection") {
            var view: UICollectionView!
            beforeEach {
                view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
            }
            it("should relay delegate") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.delegate,
                    keyPath: \.delegate,
                    with: self
                ) { changes, oldValue in
                    expect(oldValue).to(beNil())
                    guard let spec = changes.new as? UICollectionViewRelayCollectionSpec else {
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
                    guard let spec = changes.new as? UICollectionViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay collectionViewLayout") {
                let layout = UICollectionViewLayout()
                testRelay(
                    for: view,
                    relay: view.bondableRelays.collectionViewLayout,
                    keyPath: \.collectionViewLayout,
                    with: layout
                ) { changes, oldValue in
                    expect(changes.new).to(equal(layout))
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
                    guard let spec = changes.new as? UICollectionViewRelayCollectionSpec else {
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
                    guard let spec = changes.new as? UICollectionViewRelayCollectionSpec else {
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
                    guard let spec = changes.new as? UICollectionViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay isPrefetchingEnabled") {
                testRelay(
                    for: view,
                    relay: view.bondableRelays.isPrefetchingEnabled,
                    keyPath: \.isPrefetchingEnabled
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
                if #available(iOS 14.0, *) {
                    testRelay(
                        for: view,
                        relay: view.bondableRelays.isEditing,
                        keyPath: \.isEditing
                    )
                }
            }
        }
    }
}

extension UICollectionViewRelayCollectionSpec:
    UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) { }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}

@available(iOS 11.0, *)
extension UICollectionViewRelayCollectionSpec: UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        []
    }
    
}
#endif
