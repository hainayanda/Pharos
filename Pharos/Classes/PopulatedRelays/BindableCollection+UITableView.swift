//
//  UIViewRelayCollection+UITableView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var rowHeightKey: String = "rowHeightKey"
fileprivate var delegateKey: String = "delegateKey"
fileprivate var dataSourceKey: String = "dataSourceKey"
fileprivate var prefetchDataSourceKey: String = "prefetchDataSourceKey"
fileprivate var isPrefetchingEnabledKey: String = "isPrefetchingEnabledKey"
fileprivate var dragDelegateKey: String = "dragDelegateKey"
fileprivate var dropDelegateKey: String = "dropDelegateKey"
fileprivate var dragInteractionEnabledKey: String = "dragInteractionEnabledKey"
fileprivate var backgroundViewKey: String = "backgroundViewKey"
fileprivate var allowsSelectionKey: String = "allowsSelectionKey"
fileprivate var allowsMultipleSelectionKey: String = "allowsMultipleSelectionKey"
fileprivate var remembersLastFocusedIndexPathKey: String = "remembersLastFocusedIndexPathKey"
fileprivate var selectionFollowsFocusKey: String = "selectionFollowsFocusKey"
fileprivate var isEditingKey: String = "isEditingKey"
fileprivate var sectionHeaderHeightKey: String = "sectionHeaderHeightKey"
fileprivate var sectionFooterHeightKey: String = "sectionFooterHeightKey"
fileprivate var estimatedRowHeightKey: String = "estimatedRowHeightKey"
fileprivate var separatorInsetKey: String = "separatorInsetKey"
fileprivate var sectionIndexMinimumDisplayRowCountKey: String = "sectionIndexMinimumDisplayRowCountKey"
fileprivate var sectionIndexColorKey: String = "sectionIndexColorKey"
fileprivate var sectionIndexBackgroundColorKey: String = "sectionIndexBackgroundColorKey"
fileprivate var sectionIndexTrackingBackgroundColorKey: String = "sectionIndexTrackingBackgroundColorKey"
fileprivate var separatorStyleKey: String = "separatorStyleKey"
fileprivate var separatorEffectKey: String = "separatorEffectKey"
fileprivate var separatorColorKey: String = "separatorColorKey"
fileprivate var tableHeaderViewKey: String = "tableHeaderViewKey"
fileprivate var estimatedSectionHeaderHeightKey: String = "estimatedSectionHeaderHeightKey"
fileprivate var estimatedSectionFooterHeightKey: String = "estimatedSectionFooterHeightKey"
fileprivate var cellLayoutMarginsFollowReadableWidthKey: String = "cellLayoutMarginsFollowReadableWidthKey"
fileprivate var insetsContentViewsToSafeAreaKey: String = "insetsContentViewsToSafeAreaKey"
fileprivate var tableFooterViewKey: String = "tableFooterViewKey"

public extension BindableCollection where Object: UITableView {
    
    // MARK: Two Way Relay
    
    var dataSource: BindableObservable<UITableViewDataSource?> {
        bindable(of: \.dataSource, key: &dataSourceKey)
    }
    
    var delegate: BindableObservable<UITableViewDelegate?> {
        bindable(of: \.delegate, key: &delegateKey)
    }
    
    var prefetchDataSource: BindableObservable<UITableViewDataSourcePrefetching?> {
        bindable(of: \.prefetchDataSource, key: &prefetchDataSourceKey)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: BindableObservable<UITableViewDragDelegate?> {
        bindable(of: \.dragDelegate, key: &dragDelegateKey)
    }
    
    @available(iOS 11.0, *)
    var dropDelegate: BindableObservable<UITableViewDropDelegate?> {
        bindable(of: \.dropDelegate, key: &dropDelegateKey)
    }
    
    var rowHeight: BindableObservable<CGFloat> {
        bindable(of: \.rowHeight, key: &rowHeightKey)
    }
    
    var sectionHeaderHeight: BindableObservable<CGFloat> {
        bindable(of: \.sectionHeaderHeight, key: &sectionHeaderHeightKey)
    }
    
    var sectionFooterHeight: BindableObservable<CGFloat> {
        bindable(of: \.sectionFooterHeight, key: &sectionFooterHeightKey)
    }
    
    var estimatedRowHeight: BindableObservable<CGFloat> {
        bindable(of: \.estimatedRowHeight, key: &estimatedRowHeightKey)
    }
    
    var estimatedSectionHeaderHeight: BindableObservable<CGFloat> {
        bindable(of: \.estimatedSectionHeaderHeight, key: &estimatedSectionHeaderHeightKey)
    }
    
    var estimatedSectionFooterHeight: BindableObservable<CGFloat> {
        bindable(of: \.estimatedSectionFooterHeight, key: &estimatedSectionFooterHeightKey)
    }
    
    var separatorInset: BindableObservable<UIEdgeInsets> {
        bindable(of: \.separatorInset, key: &separatorInsetKey)
    }
    
    var backgroundView: BindableObservable<UIView?> {
        bindable(of: \.backgroundView, key: &backgroundViewKey)
    }
    
    var isEditing: BindableObservable<Bool> {
        bindable(of: \.isEditing, key: &isEditingKey)
    }
    
    var allowsSelection: BindableObservable<Bool> {
        bindable(of: \.allowsSelection, key: &allowsSelectionKey)
    }
    
    var allowsMultipleSelection: BindableObservable<Bool> {
        bindable(of: \.allowsMultipleSelection, key: &allowsMultipleSelectionKey)
    }
    
    var sectionIndexMinimumDisplayRowCount: BindableObservable<Int> {
        bindable(of: \.sectionIndexMinimumDisplayRowCount, key: &sectionIndexMinimumDisplayRowCountKey)
    }
    
    var sectionIndexColor: BindableObservable<UIColor?> {
        bindable(of: \.sectionIndexColor, key: &sectionIndexColorKey)
    }
    
    var sectionIndexBackgroundColor: BindableObservable<UIColor?> {
        bindable(of: \.sectionIndexBackgroundColor, key: &sectionIndexBackgroundColorKey)
    }
    
    var sectionIndexTrackingBackgroundColor: BindableObservable<UIColor?> {
        bindable(of: \.sectionIndexTrackingBackgroundColor, key: &sectionIndexTrackingBackgroundColorKey)
    }
    
    var separatorStyle: BindableObservable<UITableViewCell.SeparatorStyle> {
        bindable(of: \.separatorStyle, key: &separatorStyleKey)
    }
    
    var separatorColor: BindableObservable<UIColor?> {
        bindable(of: \.separatorColor, key: &separatorColorKey)
    }
    
    var separatorEffect: BindableObservable<UIVisualEffect?> {
        bindable(of: \.separatorEffect, key: &separatorEffectKey)
    }
    
    var cellLayoutMarginsFollowReadableWidth: BindableObservable<Bool> {
        bindable(of: \.cellLayoutMarginsFollowReadableWidth, key: &cellLayoutMarginsFollowReadableWidthKey)
    }
    
    @available(iOS 11.0, *)
    var insetsContentViewsToSafeArea: BindableObservable<Bool> {
        bindable(of: \.insetsContentViewsToSafeArea, key: &insetsContentViewsToSafeAreaKey)
    }
    
    var tableHeaderView: BindableObservable<UIView?> {
        bindable(of: \.tableHeaderView, key: &tableHeaderViewKey)
    }
    
    var tableFooterView: BindableObservable<UIView?> {
        bindable(of: \.tableFooterView, key: &tableFooterViewKey)
    }
    
    var remembersLastFocusedIndexPath: BindableObservable<Bool> {
        bindable(of: \.remembersLastFocusedIndexPath, key: &remembersLastFocusedIndexPathKey)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: BindableObservable<Bool> {
        bindable(of: \.selectionFollowsFocus, key: &selectionFollowsFocusKey)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: BindableObservable<Bool> {
        bindable(of: \.dragInteractionEnabled, key: &dragInteractionEnabledKey)
    }
    
}
#endif
