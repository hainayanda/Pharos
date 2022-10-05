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
// swiftlint:disable function_body_length

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
                    relay: view.bindables.delegate,
                    keyPath: \.delegate,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
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
                    relay: view.bindables.dataSource,
                    keyPath: \.dataSource,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
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
                    relay: view.bindables.collectionViewLayout,
                    keyPath: \.collectionViewLayout,
                    with: layout
                ) { changes, _ in
                    expect(changes.new).to(equal(layout))
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
                    relay: view.bindables.dragDelegate,
                    keyPath: \.dragDelegate,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
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
                    relay: view.bindables.dropDelegate,
                    keyPath: \.dropDelegate,
                    with: self
                ) { changes, old in
                    expect(old).to(beNil())
                    guard let spec = changes.new as? UICollectionViewRelayCollectionSpec else {
                        fail()
                        return
                    }
                    expect(spec).to(equal(self))
                }
            }
            it("should relay isPrefetchingEnabled") {
                testBoolRelay(
                    for: view,
                    relay: view.bindables.isPrefetchingEnabled,
                    keyPath: \.isPrefetchingEnabled
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
                if #available(iOS 14.0, *) {
                    testBoolRelay(
                        for: view,
                        relay: view.bindables.isEditing,
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
