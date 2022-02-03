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
    
    var dataSource: BindableRelay<UITableViewDataSource?> {
        bindable(of:\.dataSource)
    }
    
    var delegate: BindableRelay<UITableViewDelegate?> {
        bindable(of:\.delegate)
    }
    
    var prefetchDataSource: BindableRelay<UITableViewDataSourcePrefetching?> {
        bindable(of:\.prefetchDataSource)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: BindableRelay<UITableViewDragDelegate?> {
        bindable(of:\.dragDelegate)
    }
    
    @available(iOS 11.0, *)
    var dropDelegate: BindableRelay<UITableViewDropDelegate?> {
        bindable(of:\.dropDelegate)
    }
    
    var rowHeight: BindableRelay<CGFloat> {
        bindable(of:\.rowHeight)
    }
    
    var sectionHeaderHeight: BindableRelay<CGFloat> {
        bindable(of:\.sectionHeaderHeight)
    }
    
    var sectionFooterHeight: BindableRelay<CGFloat> {
        bindable(of:\.sectionFooterHeight)
    }
    
    var estimatedRowHeight: BindableRelay<CGFloat> {
        bindable(of:\.estimatedRowHeight)
    }
    
    var estimatedSectionHeaderHeight: BindableRelay<CGFloat> {
        bindable(of:\.estimatedSectionHeaderHeight)
    }
    
    var estimatedSectionFooterHeight: BindableRelay<CGFloat> {
        bindable(of:\.estimatedSectionFooterHeight)
    }
    
    var separatorInset: BindableRelay<UIEdgeInsets> {
        bindable(of:\.separatorInset)
    }
    
    var backgroundView: BindableRelay<UIView?> {
        bindable(of:\.backgroundView)
    }
    
    var isEditing: BindableRelay<Bool> {
        bindable(of:\.isEditing)
    }
    
    var allowsSelection: BindableRelay<Bool> {
        bindable(of:\.allowsSelection)
    }
    
    var allowsMultipleSelection: BindableRelay<Bool> {
        bindable(of:\.allowsMultipleSelection)
    }
    
    var sectionIndexMinimumDisplayRowCount: BindableRelay<Int> {
        bindable(of:\.sectionIndexMinimumDisplayRowCount)
    }
    
    var sectionIndexColor: BindableRelay<UIColor?> {
        bindable(of:\.sectionIndexColor)
    }
    
    var sectionIndexBackgroundColor: BindableRelay<UIColor?> {
        bindable(of:\.sectionIndexBackgroundColor)
    }
    
    var sectionIndexTrackingBackgroundColor: BindableRelay<UIColor?> {
        bindable(of:\.sectionIndexTrackingBackgroundColor)
    }
    
    var separatorStyle: BindableRelay<UITableViewCell.SeparatorStyle> {
        bindable(of:\.separatorStyle)
    }
    
    var separatorColor: BindableRelay<UIColor?> {
        bindable(of:\.separatorColor)
    }
    
    var separatorEffect: BindableRelay<UIVisualEffect?> {
        bindable(of:\.separatorEffect)
    }
    
    var cellLayoutMarginsFollowReadableWidth: BindableRelay<Bool> {
        bindable(of:\.cellLayoutMarginsFollowReadableWidth)
    }
    
    @available(iOS 11.0, *)
    var insetsContentViewsToSafeArea: BindableRelay<Bool> {
        bindable(of:\.insetsContentViewsToSafeArea)
    }
    
    var tableHeaderView: BindableRelay<UIView?> {
        bindable(of:\.tableHeaderView)
    }
    
    var tableFooterView: BindableRelay<UIView?> {
        bindable(of:\.tableFooterView)
    }
    
    var remembersLastFocusedIndexPath: BindableRelay<Bool> {
        bindable(of:\.remembersLastFocusedIndexPath)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: BindableRelay<Bool> {
        bindable(of:\.selectionFollowsFocus)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: BindableRelay<Bool> {
        bindable(of:\.dragInteractionEnabled)
    }
    
}
#endif
