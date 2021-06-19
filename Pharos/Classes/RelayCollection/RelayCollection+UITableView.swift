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
        .relay(of: object, \.dataSource)
    }
    
    var delegate: AssociativeTwoWayRelay<UITableViewDelegate?> {
        .relay(of: object, \.delegate)
    }
    
    var prefetchDataSource: AssociativeTwoWayRelay<UITableViewDataSourcePrefetching?> {
        .relay(of: object, \.prefetchDataSource)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: AssociativeTwoWayRelay<UITableViewDragDelegate?> {
        .relay(of: object, \.dragDelegate)
    }
    
    @available(iOS 11.0, *)
    var dropDelegate: AssociativeTwoWayRelay<UITableViewDropDelegate?> {
        .relay(of: object, \.dropDelegate)
    }
    
    var rowHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.rowHeight)
    }
    
    var sectionHeaderHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.sectionHeaderHeight)
    }
    
    var sectionFooterHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.sectionFooterHeight)
    }
    
    var estimatedRowHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.estimatedRowHeight)
    }
    
    var estimatedSectionHeaderHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.estimatedSectionHeaderHeight)
    }
    
    var estimatedSectionFooterHeight: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.estimatedSectionFooterHeight)
    }
    
    var separatorInset: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.separatorInset)
    }
    
    var backgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.backgroundView)
    }
    
    var isEditing: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isEditing)
    }
    
    var allowsSelection: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.allowsSelection)
    }
    
    var allowsMultipleSelection: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.allowsMultipleSelection)
    }
    
    var sectionIndexMinimumDisplayRowCount: AssociativeTwoWayRelay<Int> {
        .relay(of: object, \.sectionIndexMinimumDisplayRowCount)
    }
    
    var sectionIndexColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.sectionIndexColor)
    }
    
    var sectionIndexBackgroundColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.sectionIndexBackgroundColor)
    }
    
    var sectionIndexTrackingBackgroundColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.sectionIndexTrackingBackgroundColor)
    }
    
    var separatorStyle: AssociativeTwoWayRelay<UITableViewCell.SeparatorStyle> {
        .relay(of: object, \.separatorStyle)
    }
    
    var separatorColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.separatorColor)
    }
    
    var separatorEffect: AssociativeTwoWayRelay<UIVisualEffect?> {
        .relay(of: object, \.separatorEffect)
    }
    
    var cellLayoutMarginsFollowReadableWidth: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.cellLayoutMarginsFollowReadableWidth)
    }
    
    @available(iOS 11.0, *)
    var insetsContentViewsToSafeArea: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.insetsContentViewsToSafeArea)
    }
    
    var tableHeaderView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.tableHeaderView)
    }
    
    var tableFooterView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.tableFooterView)
    }
    
    var remembersLastFocusedIndexPath: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.remembersLastFocusedIndexPath)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.selectionFollowsFocus)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.dragInteractionEnabled)
    }
    
}
#endif
