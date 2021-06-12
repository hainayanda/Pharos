//
//  UIViewRelayCollection+UITableView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UITableView: PopulatedRelays {
    public typealias BaseRelayObject = UITableView
}

public extension RelayCollection where Object: UITableView {
    
    // MARK: Two Way Relay
    
    var dataSource: TwoWayRelay<UITableViewDataSource?> {
        .relay(of: object, \.dataSource)
    }
    
    var delegate: TwoWayRelay<UITableViewDelegate?> {
        .relay(of: object, \.delegate)
    }
    
    var prefetchDataSource: TwoWayRelay<UITableViewDataSourcePrefetching?> {
        .relay(of: object, \.prefetchDataSource)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: TwoWayRelay<UITableViewDragDelegate?> {
        .relay(of: object, \.dragDelegate)
    }
    
    @available(iOS 11.0, *)
    var dropDelegate: TwoWayRelay<UITableViewDropDelegate?> {
        .relay(of: object, \.dropDelegate)
    }
    
    var rowHeight: TwoWayRelay<CGFloat> {
        .relay(of: object, \.rowHeight)
    }
    
    var sectionHeaderHeight: TwoWayRelay<CGFloat> {
        .relay(of: object, \.sectionHeaderHeight)
    }
    
    var sectionFooterHeight: TwoWayRelay<CGFloat> {
        .relay(of: object, \.sectionFooterHeight)
    }
    
    var estimatedRowHeight: TwoWayRelay<CGFloat> {
        .relay(of: object, \.estimatedRowHeight)
    }
    
    var estimatedSectionHeaderHeight: TwoWayRelay<CGFloat> {
        .relay(of: object, \.estimatedSectionHeaderHeight)
    }
    
    var estimatedSectionFooterHeight: TwoWayRelay<CGFloat> {
        .relay(of: object, \.estimatedSectionFooterHeight)
    }
    
    var separatorInset: TwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.separatorInset)
    }
    
    @available(iOS 11.0, *)
    var separatorInsetReference: TwoWayRelay<UITableView.SeparatorInsetReference> {
        .relay(of: object, \.separatorInsetReference)
    }
    
    var backgroundView: TwoWayRelay<UIView?> {
        .relay(of: object, \.backgroundView)
    }
    
    var isEditing: TwoWayRelay<Bool> {
        .relay(of: object, \.isEditing)
    }
    
    var allowsSelection: TwoWayRelay<Bool> {
        .relay(of: object, \.allowsSelection)
    }
    
    var allowsSelectionDuringEditing: TwoWayRelay<Bool> {
        .relay(of: object, \.allowsSelectionDuringEditing)
    }
    
    var allowsMultipleSelection: TwoWayRelay<Bool> {
        .relay(of: object, \.allowsMultipleSelection)
    }
    
    var allowsMultipleSelectionDuringEditing: TwoWayRelay<Bool> {
        .relay(of: object, \.allowsMultipleSelectionDuringEditing)
    }
    
    var sectionIndexMinimumDisplayRowCount: TwoWayRelay<Int> {
        .relay(of: object, \.sectionIndexMinimumDisplayRowCount)
    }
    
    var sectionIndexColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.sectionIndexColor)
    }
    
    var sectionIndexBackgroundColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.sectionIndexBackgroundColor)
    }
    
    var sectionIndexTrackingBackgroundColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.sectionIndexTrackingBackgroundColor)
    }
    
    var separatorStyle: TwoWayRelay<UITableViewCell.SeparatorStyle> {
        .relay(of: object, \.separatorStyle)
    }
    
    var separatorColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.separatorColor)
    }
    
    var separatorEffect: TwoWayRelay<UIVisualEffect?> {
        .relay(of: object, \.separatorEffect)
    }
    
    var cellLayoutMarginsFollowReadableWidth: TwoWayRelay<Bool> {
        .relay(of: object, \.cellLayoutMarginsFollowReadableWidth)
    }
    
    @available(iOS 11.0, *)
    var insetsContentViewsToSafeArea: TwoWayRelay<Bool> {
        .relay(of: object, \.insetsContentViewsToSafeArea)
    }
    
    var tableHeaderView: TwoWayRelay<UIView?> {
        .relay(of: object, \.tableHeaderView)
    }
    
    var tableFooterView: TwoWayRelay<UIView?> {
        .relay(of: object, \.tableFooterView)
    }
    
    var remembersLastFocusedIndexPath: TwoWayRelay<Bool> {
        .relay(of: object, \.remembersLastFocusedIndexPath)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: TwoWayRelay<Bool> {
        .relay(of: object, \.selectionFollowsFocus)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.dragInteractionEnabled)
    }
    
    // MARK: Value Relay
    
    var style: ValueRelay<UITableView.Style> {
        .relay(of: object, \.style)
    }
    
    var numberOfSections: ValueRelay<Int> {
        .relay(of: object, \.numberOfSections)
    }
    
    var visibleCells: ValueRelay<[UITableViewCell]> {
        .relay(of: object, \.visibleCells)
    }
    
    var indexPathsForVisibleRows: ValueRelay<[IndexPath]?> {
        .relay(of: object, \.indexPathsForVisibleRows)
    }
    
    @available(iOS 11.0, *)
    var hasUncommittedUpdates: ValueRelay<Bool> {
        .relay(of: object, \.hasUncommittedUpdates)
    }
    
    var indexPathForSelectedRow: ValueRelay<IndexPath?> {
        .relay(of: object, \.indexPathForSelectedRow)
    }
    
    var indexPathsForSelectedRows: ValueRelay<[IndexPath]?> {
        .relay(of: object, \.indexPathsForSelectedRows)
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
