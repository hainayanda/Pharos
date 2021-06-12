//
//  RelayCollection+UICollectionView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UICollectionView: PopulatedRelays {
    public typealias BaseRelayObject = UICollectionView
}

public extension RelayCollection where Object: UICollectionView {
    
    // MARK: Two Way Relay
    
    var collectionViewLayout: TwoWayRelay<UICollectionViewLayout> {
        .relay(of: object, \.collectionViewLayout)
    }
    
    var delegate: TwoWayRelay<UICollectionViewDelegate?> {
        .relay(of: object, \.delegate)
    }
    
    var dataSource: TwoWayRelay<UICollectionViewDataSource?> {
        .relay(of: object, \.dataSource)
    }
    
    var prefetchDataSource: TwoWayRelay<UICollectionViewDataSourcePrefetching?> {
        .relay(of: object, \.prefetchDataSource)
    }
    
    var isPrefetchingEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isPrefetchingEnabled)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: TwoWayRelay<UICollectionViewDragDelegate?> {
        .relay(of: object, \.dragDelegate)
    }
    @available(iOS 11.0, *)
    var dropDelegate: TwoWayRelay<UICollectionViewDropDelegate?> {
        .relay(of: object, \.dropDelegate)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.dragInteractionEnabled)
    }
    
    @available(iOS 11.0, *)
    var reorderingCadence: TwoWayRelay<UICollectionView.ReorderingCadence> {
        .relay(of: object, \.reorderingCadence)
    }
    
    var backgroundView: TwoWayRelay<UIView?> {
        .relay(of: object, \.backgroundView)
    }
    
    var allowsSelection: TwoWayRelay<Bool> {
        .relay(of: object, \.allowsSelection)
    }
    
    var allowsMultipleSelection: TwoWayRelay<Bool> {
        .relay(of: object, \.allowsMultipleSelection)
    }
    
    var remembersLastFocusedIndexPath: TwoWayRelay<Bool> {
        .relay(of: object, \.remembersLastFocusedIndexPath)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: TwoWayRelay<Bool> {
        .relay(of: object, \.selectionFollowsFocus)
    }
    
    @available(iOS 14.0, *)
    var isEditing: TwoWayRelay<Bool> {
        .relay(of: object, \.isEditing)
    }
    
    @available(iOS 14.0, *)
    var allowsSelectionDuringEditing: TwoWayRelay<Bool> {
        .relay(of: object, \.allowsSelectionDuringEditing)
    }
    
    @available(iOS 14.0, *)
    var allowsMultipleSelectionDuringEditing: TwoWayRelay<Bool> {
        .relay(of: object, \.allowsMultipleSelectionDuringEditing)
    }
    
    // MARK: Value Relay
    
    var indexPathsForSelectedItems: ValueRelay<[IndexPath]?> {
        .relay(of: object, \.indexPathsForSelectedItems)
    }
    
    @available(iOS 11.0, *)
    var hasUncommittedUpdates: ValueRelay<Bool> {
        .relay(of: object, \.hasUncommittedUpdates)
    }
    
    var numberOfSections: ValueRelay<Int> {
        .relay(of: object, \.numberOfSections)
    }
    
    var visibleCells: ValueRelay<[UICollectionViewCell]> {
        .relay(of: object, \.visibleCells)
    }
    
    var indexPathsForVisibleItems: ValueRelay<[IndexPath]> {
        .relay(of: object, \.indexPathsForVisibleItems)
    }
    
    @available(iOS 11.0, *)
    var hasActiveDrag: ValueRelay<Bool> {
        .relay(of: object, \.hasActiveDrag)
    }
    
    @available(iOS 11.0, *)
    var hasActiveDrop: ValueRelay<Bool> {
        .relay(of: object, \.hasActiveDrop)
    }
    
}
#endif
