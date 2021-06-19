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
        .relay(of: object, \.collectionViewLayout)
    }
    
    var delegate: AssociativeTwoWayRelay<UICollectionViewDelegate?> {
        .relay(of: object, \.delegate)
    }
    
    var dataSource: AssociativeTwoWayRelay<UICollectionViewDataSource?> {
        .relay(of: object, \.dataSource)
    }
    
    var prefetchDataSource: AssociativeTwoWayRelay<UICollectionViewDataSourcePrefetching?> {
        .relay(of: object, \.prefetchDataSource)
    }
    
    var isPrefetchingEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isPrefetchingEnabled)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: AssociativeTwoWayRelay<UICollectionViewDragDelegate?> {
        .relay(of: object, \.dragDelegate)
    }
    @available(iOS 11.0, *)
    var dropDelegate: AssociativeTwoWayRelay<UICollectionViewDropDelegate?> {
        .relay(of: object, \.dropDelegate)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.dragInteractionEnabled)
    }
    
    var backgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.backgroundView)
    }
    
    var allowsSelection: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.allowsSelection)
    }
    
    var allowsMultipleSelection: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.allowsMultipleSelection)
    }
    
    var remembersLastFocusedIndexPath: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.remembersLastFocusedIndexPath)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.selectionFollowsFocus)
    }
    
    @available(iOS 14.0, *)
    var isEditing: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isEditing)
    }
    
}
#endif
