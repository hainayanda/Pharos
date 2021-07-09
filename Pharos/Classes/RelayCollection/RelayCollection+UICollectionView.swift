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
    
    var collectionViewLayout: AssociativeTwoWayRelay<UICollectionViewLayout> {
        .relay(of: underlyingObject, \.collectionViewLayout)
    }
    
    var delegate: AssociativeTwoWayRelay<UICollectionViewDelegate?> {
        .relay(of: underlyingObject, \.delegate)
    }
    
    var dataSource: AssociativeTwoWayRelay<UICollectionViewDataSource?> {
        .relay(of: underlyingObject, \.dataSource)
    }
    
    var prefetchDataSource: AssociativeTwoWayRelay<UICollectionViewDataSourcePrefetching?> {
        .relay(of: underlyingObject, \.prefetchDataSource)
    }
    
    var isPrefetchingEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isPrefetchingEnabled)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: AssociativeTwoWayRelay<UICollectionViewDragDelegate?> {
        .relay(of: underlyingObject, \.dragDelegate)
    }
    @available(iOS 11.0, *)
    var dropDelegate: AssociativeTwoWayRelay<UICollectionViewDropDelegate?> {
        .relay(of: underlyingObject, \.dropDelegate)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.dragInteractionEnabled)
    }
    
    var backgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.backgroundView)
    }
    
    var allowsSelection: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.allowsSelection)
    }
    
    var allowsMultipleSelection: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.allowsMultipleSelection)
    }
    
    var remembersLastFocusedIndexPath: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.remembersLastFocusedIndexPath)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.selectionFollowsFocus)
    }
    
    @available(iOS 14.0, *)
    var isEditing: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isEditing)
    }
    
}
#endif
