//
//  RelayCollection+UICollectionView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var collectionViewLayoutKey: String = "collectionViewLayoutKey"
private var delegateKey: String = "delegateKey"
private var dataSourceKey: String = "dataSourceKey"
private var prefetchDataSourceKey: String = "prefetchDataSourceKey"
private var isPrefetchingEnabledKey: String = "isPrefetchingEnabledKey"
private var dragDelegateKey: String = "dragDelegateKey"
private var dropDelegateKey: String = "dropDelegateKey"
private var dragInteractionEnabledKey: String = "dragInteractionEnabledKey"
private var backgroundViewKey: String = "backgroundViewKey"
private var allowsSelectionKey: String = "allowsSelectionKey"
private var allowsMultipleSelectionKey: String = "allowsMultipleSelectionKey"
private var remembersLastFocusedIndexPathKey: String = "remembersLastFocusedIndexPathKey"
private var selectionFollowsFocusKey: String = "selectionFollowsFocusKey"
private var isEditingKey: String = "isEditingKey"

public extension BindableCollection where Object: UICollectionView {
    
    // MARK: Two Way Relay
    
    var collectionViewLayout: Observable<UICollectionViewLayout> {
        bindable(of: \.collectionViewLayout, key: &collectionViewLayoutKey)
    }
    
    var delegate: Observable<UICollectionViewDelegate?> {
        bindable(of: \.delegate, key: &delegateKey)
    }
    
    var dataSource: Observable<UICollectionViewDataSource?> {
        bindable(of: \.dataSource, key: &dataSourceKey)
    }
    
    var prefetchDataSource: Observable<UICollectionViewDataSourcePrefetching?> {
        bindable(of: \.prefetchDataSource, key: &prefetchDataSourceKey)
    }
    
    var isPrefetchingEnabled: Observable<Bool> {
        bindable(of: \.isPrefetchingEnabled, key: &isPrefetchingEnabledKey)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: Observable<UICollectionViewDragDelegate?> {
        bindable(of: \.dragDelegate, key: &dragDelegateKey)
    }
    @available(iOS 11.0, *)
    var dropDelegate: Observable<UICollectionViewDropDelegate?> {
        bindable(of: \.dropDelegate, key: &dropDelegateKey)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: Observable<Bool> {
        bindable(of: \.dragInteractionEnabled, key: &dragInteractionEnabledKey)
    }
    
    var backgroundView: Observable<UIView?> {
        bindable(of: \.backgroundView, key: &backgroundViewKey)
    }
    
    var allowsSelection: Observable<Bool> {
        bindable(of: \.allowsSelection, key: &allowsSelectionKey)
    }
    
    var allowsMultipleSelection: Observable<Bool> {
        bindable(of: \.allowsMultipleSelection, key: &allowsMultipleSelectionKey)
    }
    
    var remembersLastFocusedIndexPath: Observable<Bool> {
        bindable(of: \.remembersLastFocusedIndexPath, key: &remembersLastFocusedIndexPathKey)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: Observable<Bool> {
        bindable(of: \.selectionFollowsFocus, key: &selectionFollowsFocusKey)
    }
    
    @available(iOS 14.0, *)
    var isEditing: Observable<Bool> {
        bindable(of: \.isEditing, key: &isEditingKey)
    }
    
}
#endif
