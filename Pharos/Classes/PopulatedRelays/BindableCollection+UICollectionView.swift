//
//  RelayCollection+UICollectionView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UICollectionView {
    
    // MARK: Two Way Relay
    
    var collectionViewLayout: BindableObservable<UICollectionViewLayout> {
        bindable(of:\.collectionViewLayout)
    }
    
    var delegate: BindableObservable<UICollectionViewDelegate?> {
        bindable(of:\.delegate)
    }
    
    var dataSource: BindableObservable<UICollectionViewDataSource?> {
        bindable(of:\.dataSource)
    }
    
    var prefetchDataSource: BindableObservable<UICollectionViewDataSourcePrefetching?> {
        bindable(of:\.prefetchDataSource)
    }
    
    var isPrefetchingEnabled: BindableObservable<Bool> {
        bindable(of:\.isPrefetchingEnabled)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: BindableObservable<UICollectionViewDragDelegate?> {
        bindable(of:\.dragDelegate)
    }
    @available(iOS 11.0, *)
    var dropDelegate: BindableObservable<UICollectionViewDropDelegate?> {
        bindable(of:\.dropDelegate)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: BindableObservable<Bool> {
        bindable(of:\.dragInteractionEnabled)
    }
    
    var backgroundView: BindableObservable<UIView?> {
        bindable(of:\.backgroundView)
    }
    
    var allowsSelection: BindableObservable<Bool> {
        bindable(of:\.allowsSelection)
    }
    
    var allowsMultipleSelection: BindableObservable<Bool> {
        bindable(of:\.allowsMultipleSelection)
    }
    
    var remembersLastFocusedIndexPath: BindableObservable<Bool> {
        bindable(of:\.remembersLastFocusedIndexPath)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: BindableObservable<Bool> {
        bindable(of:\.selectionFollowsFocus)
    }
    
    @available(iOS 14.0, *)
    var isEditing: BindableObservable<Bool> {
        bindable(of:\.isEditing)
    }
    
}
#endif
