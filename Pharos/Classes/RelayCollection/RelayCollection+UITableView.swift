//
//  UIViewRelayCollection+UITableView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UITableView {
    
    // MARK: Two Way Relay
    
    var dataSource: AssociativeTwoWayRelay<UITableViewDataSource?> {
        .relay(of: underlyingObject, \.dataSource)
    }
    
    var delegate: AssociativeTwoWayRelay<UITableViewDelegate?> {
        .relay(of: underlyingObject, \.delegate)
    }
    
    var prefetchDataSource: AssociativeTwoWayRelay<UITableViewDataSourcePrefetching?> {
        .relay(of: underlyingObject, \.prefetchDataSource)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: AssociativeTwoWayRelay<UITableViewDragDelegate?> {
        .relay(of: underlyingObject, \.dragDelegate)
    }
    
    @available(iOS 11.0, *)
    var dropDelegate: AssociativeTwoWayRelay<UITableViewDropDelegate?> {
        .relay(of: underlyingObject, \.dropDelegate)
    }
    
    var rowHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.rowHeight)
    }
    
    var sectionHeaderHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.sectionHeaderHeight)
    }
    
    var sectionFooterHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.sectionFooterHeight)
    }
    
    var estimatedRowHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.estimatedRowHeight)
    }
    
    var estimatedSectionHeaderHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.estimatedSectionHeaderHeight)
    }
    
    var estimatedSectionFooterHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.estimatedSectionFooterHeight)
    }
    
    var separatorInset: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: underlyingObject, \.separatorInset)
    }
    
    var backgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.backgroundView)
    }
    
    var isEditing: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isEditing)
    }
    
    var allowsSelection: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.allowsSelection)
    }
    
    var allowsMultipleSelection: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.allowsMultipleSelection)
    }
    
    var sectionIndexMinimumDisplayRowCount: AssociativeTwoWayRelay<Int> {
        .relay(of: underlyingObject, \.sectionIndexMinimumDisplayRowCount)
    }
    
    var sectionIndexColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.sectionIndexColor)
    }
    
    var sectionIndexBackgroundColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.sectionIndexBackgroundColor)
    }
    
    var sectionIndexTrackingBackgroundColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.sectionIndexTrackingBackgroundColor)
    }
    
    var separatorStyle: AssociativeTwoWayRelay<UITableViewCell.SeparatorStyle> {
        .relay(of: underlyingObject, \.separatorStyle)
    }
    
    var separatorColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.separatorColor)
    }
    
    var separatorEffect: AssociativeTwoWayRelay<UIVisualEffect?> {
        .relay(of: underlyingObject, \.separatorEffect)
    }
    
    var cellLayoutMarginsFollowReadableWidth: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.cellLayoutMarginsFollowReadableWidth)
    }
    
    @available(iOS 11.0, *)
    var insetsContentViewsToSafeArea: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.insetsContentViewsToSafeArea)
    }
    
    var tableHeaderView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.tableHeaderView)
    }
    
    var tableFooterView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.tableFooterView)
    }
    
    var remembersLastFocusedIndexPath: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.remembersLastFocusedIndexPath)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.selectionFollowsFocus)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.dragInteractionEnabled)
    }
    
}
#endif
