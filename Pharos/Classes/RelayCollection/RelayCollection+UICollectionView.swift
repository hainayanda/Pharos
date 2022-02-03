//
//  RelayCollection+UICollectionView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UICollectionView {
    
    // MARK: Two Way Relay
    
    var collectionViewLayout: BindableRelay<UICollectionViewLayout> {
        bindable(of:\.collectionViewLayout)
    }
    
    var delegate: BindableRelay<UICollectionViewDelegate?> {
        bindable(of:\.delegate)
    }
    
    var dataSource: BindableRelay<UICollectionViewDataSource?> {
        bindable(of:\.dataSource)
    }
    
    var prefetchDataSource: BindableRelay<UICollectionViewDataSourcePrefetching?> {
        bindable(of:\.prefetchDataSource)
    }
    
    var isPrefetchingEnabled: BindableRelay<Bool> {
        bindable(of:\.isPrefetchingEnabled)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: BindableRelay<UICollectionViewDragDelegate?> {
        bindable(of:\.dragDelegate)
    }
    @available(iOS 11.0, *)
    var dropDelegate: BindableRelay<UICollectionViewDropDelegate?> {
        bindable(of:\.dropDelegate)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: BindableRelay<Bool> {
        bindable(of:\.dragInteractionEnabled)
    }
    
    var backgroundView: BindableRelay<UIView?> {
        bindable(of:\.backgroundView)
    }
    
    var allowsSelection: BindableRelay<Bool> {
        bindable(of:\.allowsSelection)
    }
    
    var allowsMultipleSelection: BindableRelay<Bool> {
        bindable(of:\.allowsMultipleSelection)
    }
    
    var remembersLastFocusedIndexPath: BindableRelay<Bool> {
        bindable(of:\.remembersLastFocusedIndexPath)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: BindableRelay<Bool> {
        bindable(of:\.selectionFollowsFocus)
    }
    
    @available(iOS 14.0, *)
    var isEditing: BindableRelay<Bool> {
        bindable(of:\.isEditing)
    }
    
}
#endif
