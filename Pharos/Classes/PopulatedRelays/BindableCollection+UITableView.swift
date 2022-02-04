//
//  UIViewRelayCollection+UITableView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UITableView {
    
    // MARK: Two Way Relay
    
    var dataSource: BindableObservable<UITableViewDataSource?> {
        bindable(of:\.dataSource)
    }
    
    var delegate: BindableObservable<UITableViewDelegate?> {
        bindable(of:\.delegate)
    }
    
    var prefetchDataSource: BindableObservable<UITableViewDataSourcePrefetching?> {
        bindable(of:\.prefetchDataSource)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: BindableObservable<UITableViewDragDelegate?> {
        bindable(of:\.dragDelegate)
    }
    
    @available(iOS 11.0, *)
    var dropDelegate: BindableObservable<UITableViewDropDelegate?> {
        bindable(of:\.dropDelegate)
    }
    
    var rowHeight: BindableObservable<CGFloat> {
        bindable(of:\.rowHeight)
    }
    
    var sectionHeaderHeight: BindableObservable<CGFloat> {
        bindable(of:\.sectionHeaderHeight)
    }
    
    var sectionFooterHeight: BindableObservable<CGFloat> {
        bindable(of:\.sectionFooterHeight)
    }
    
    var estimatedRowHeight: BindableObservable<CGFloat> {
        bindable(of:\.estimatedRowHeight)
    }
    
    var estimatedSectionHeaderHeight: BindableObservable<CGFloat> {
        bindable(of:\.estimatedSectionHeaderHeight)
    }
    
    var estimatedSectionFooterHeight: BindableObservable<CGFloat> {
        bindable(of:\.estimatedSectionFooterHeight)
    }
    
    var separatorInset: BindableObservable<UIEdgeInsets> {
        bindable(of:\.separatorInset)
    }
    
    var backgroundView: BindableObservable<UIView?> {
        bindable(of:\.backgroundView)
    }
    
    var isEditing: BindableObservable<Bool> {
        bindable(of:\.isEditing)
    }
    
    var allowsSelection: BindableObservable<Bool> {
        bindable(of:\.allowsSelection)
    }
    
    var allowsMultipleSelection: BindableObservable<Bool> {
        bindable(of:\.allowsMultipleSelection)
    }
    
    var sectionIndexMinimumDisplayRowCount: BindableObservable<Int> {
        bindable(of:\.sectionIndexMinimumDisplayRowCount)
    }
    
    var sectionIndexColor: BindableObservable<UIColor?> {
        bindable(of:\.sectionIndexColor)
    }
    
    var sectionIndexBackgroundColor: BindableObservable<UIColor?> {
        bindable(of:\.sectionIndexBackgroundColor)
    }
    
    var sectionIndexTrackingBackgroundColor: BindableObservable<UIColor?> {
        bindable(of:\.sectionIndexTrackingBackgroundColor)
    }
    
    var separatorStyle: BindableObservable<UITableViewCell.SeparatorStyle> {
        bindable(of:\.separatorStyle)
    }
    
    var separatorColor: BindableObservable<UIColor?> {
        bindable(of:\.separatorColor)
    }
    
    var separatorEffect: BindableObservable<UIVisualEffect?> {
        bindable(of:\.separatorEffect)
    }
    
    var cellLayoutMarginsFollowReadableWidth: BindableObservable<Bool> {
        bindable(of:\.cellLayoutMarginsFollowReadableWidth)
    }
    
    @available(iOS 11.0, *)
    var insetsContentViewsToSafeArea: BindableObservable<Bool> {
        bindable(of:\.insetsContentViewsToSafeArea)
    }
    
    var tableHeaderView: BindableObservable<UIView?> {
        bindable(of:\.tableHeaderView)
    }
    
    var tableFooterView: BindableObservable<UIView?> {
        bindable(of:\.tableFooterView)
    }
    
    var remembersLastFocusedIndexPath: BindableObservable<Bool> {
        bindable(of:\.remembersLastFocusedIndexPath)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: BindableObservable<Bool> {
        bindable(of:\.selectionFollowsFocus)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: BindableObservable<Bool> {
        bindable(of:\.dragInteractionEnabled)
    }
    
}
#endif
