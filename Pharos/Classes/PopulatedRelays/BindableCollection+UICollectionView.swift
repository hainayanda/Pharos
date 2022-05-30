//
//  RelayCollection+UICollectionView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var collectionViewLayoutKey: String = "collectionViewLayoutKey"
fileprivate var delegateKey: String = "delegateKey"
fileprivate var dataSourceKey: String = "dataSourceKey"
fileprivate var prefetchDataSourceKey: String = "prefetchDataSourceKey"
fileprivate var isPrefetchingEnabledKey: String = "isPrefetchingEnabledKey"
fileprivate var dragDelegateKey: String = "dragDelegateKey"
fileprivate var dropDelegateKey: String = "dropDelegateKey"
fileprivate var dragInteractionEnabledKey: String = "dragInteractionEnabledKey"
fileprivate var backgroundViewKey: String = "backgroundViewKey"
fileprivate var allowsSelectionKey: String = "allowsSelectionKey"
fileprivate var allowsMultipleSelectionKey: String = "allowsMultipleSelectionKey"
fileprivate var remembersLastFocusedIndexPathKey: String = "remembersLastFocusedIndexPathKey"
fileprivate var selectionFollowsFocusKey: String = "selectionFollowsFocusKey"
fileprivate var isEditingKey: String = "isEditingKey"

public extension BindableCollection where Object: UICollectionView {
    
    // MARK: Two Way Relay
    
    var collectionViewLayout: BindableObservable<UICollectionViewLayout> {
        bindable(of:\.collectionViewLayout, key: &collectionViewLayoutKey)
    }
    
    var delegate: BindableObservable<UICollectionViewDelegate?> {
        bindable(of:\.delegate, key: &delegateKey)
    }
    
    var dataSource: BindableObservable<UICollectionViewDataSource?> {
        bindable(of:\.dataSource, key: &dataSourceKey)
    }
    
    var prefetchDataSource: BindableObservable<UICollectionViewDataSourcePrefetching?> {
        bindable(of:\.prefetchDataSource, key: &prefetchDataSourceKey)
    }
    
    var isPrefetchingEnabled: BindableObservable<Bool> {
        bindable(of:\.isPrefetchingEnabled, key: &isPrefetchingEnabledKey)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: BindableObservable<UICollectionViewDragDelegate?> {
        bindable(of:\.dragDelegate, key: &dragDelegateKey)
    }
    @available(iOS 11.0, *)
    var dropDelegate: BindableObservable<UICollectionViewDropDelegate?> {
        bindable(of:\.dropDelegate, key: &dropDelegateKey)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: BindableObservable<Bool> {
        bindable(of:\.dragInteractionEnabled, key: &dragInteractionEnabledKey)
    }
    
    var backgroundView: BindableObservable<UIView?> {
        bindable(of:\.backgroundView, key: &backgroundViewKey)
    }
    
    var allowsSelection: BindableObservable<Bool> {
        bindable(of:\.allowsSelection, key: &allowsSelectionKey)
    }
    
    var allowsMultipleSelection: BindableObservable<Bool> {
        bindable(of:\.allowsMultipleSelection, key: &allowsMultipleSelectionKey)
    }
    
    var remembersLastFocusedIndexPath: BindableObservable<Bool> {
        bindable(of:\.remembersLastFocusedIndexPath, key: &remembersLastFocusedIndexPathKey)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: BindableObservable<Bool> {
        bindable(of:\.selectionFollowsFocus, key: &selectionFollowsFocusKey)
    }
    
    @available(iOS 14.0, *)
    var isEditing: BindableObservable<Bool> {
        bindable(of:\.isEditing, key: &isEditingKey)
    }
    
}
#endif
