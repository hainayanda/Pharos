//
//  UIViewRelayCollection+UITableView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var rowHeightKey: String = "rowHeightKey"
private var delegateKey: String = "delegateKey"
private var dataSourceKey: String = "dataSourceKey"
private var prefetchDataSourceKey: String = "prefetchDataSourceKey"
private var isPrefetchingEnabledKey: String = "isPrefetchingEnabledKey"
private var dragDelegateKey: String = "dragDelegateKey"
private var dropDelegateKey: String = "dropDelegateKey"
private var dragInteractionEnabledKey: String = "dragInteractionEnabledKey"
private var backgroundViewKey: String = "backgroundViewKey"
private var allowsSelectionKey: String = "allowsSelectionKey"
private var allowsMultipleSelectionKey: String = "allowsMultipleSelectionKey"
private var remembersLastFocusedIndexPathKey: String = "remembersLastFocusedIndexPathKey"
private var selectionFollowsFocusKey: String = "selectionFollowsFocusKey"
private var isEditingKey: String = "isEditingKey"
private var sectionHeaderHeightKey: String = "sectionHeaderHeightKey"
private var sectionFooterHeightKey: String = "sectionFooterHeightKey"
private var estimatedRowHeightKey: String = "estimatedRowHeightKey"
private var separatorInsetKey: String = "separatorInsetKey"
private var sectionIndexMinimumDisplayRowCountKey: String = "sectionIndexMinimumDisplayRowCountKey"
private var sectionIndexColorKey: String = "sectionIndexColorKey"
private var sectionIndexBackgroundColorKey: String = "sectionIndexBackgroundColorKey"
private var sectionIndexTrackingBackgroundColorKey: String = "sectionIndexTrackingBackgroundColorKey"
private var separatorStyleKey: String = "separatorStyleKey"
private var separatorEffectKey: String = "separatorEffectKey"
private var separatorColorKey: String = "separatorColorKey"
private var tableHeaderViewKey: String = "tableHeaderViewKey"
private var estimatedSectionHeaderHeightKey: String = "estimatedSectionHeaderHeightKey"
private var estimatedSectionFooterHeightKey: String = "estimatedSectionFooterHeightKey"
private var cellLayoutMarginsFollowReadableWidthKey: String = "cellLayoutMarginsFollowReadableWidthKey"
private var insetsContentViewsToSafeAreaKey: String = "insetsContentViewsToSafeAreaKey"
private var tableFooterViewKey: String = "tableFooterViewKey"

public extension BindableCollection where Object: UITableView {
    
    // MARK: Two Way Relay
    
    var dataSource: Observable<UITableViewDataSource?> {
        bindable(of: \.dataSource, key: &dataSourceKey)
    }
    
    var delegate: Observable<UITableViewDelegate?> {
        bindable(of: \.delegate, key: &delegateKey)
    }
    
    var prefetchDataSource: Observable<UITableViewDataSourcePrefetching?> {
        bindable(of: \.prefetchDataSource, key: &prefetchDataSourceKey)
    }
    
    @available(iOS 11.0, *)
    var dragDelegate: Observable<UITableViewDragDelegate?> {
        bindable(of: \.dragDelegate, key: &dragDelegateKey)
    }
    
    @available(iOS 11.0, *)
    var dropDelegate: Observable<UITableViewDropDelegate?> {
        bindable(of: \.dropDelegate, key: &dropDelegateKey)
    }
    
    var rowHeight: Observable<CGFloat> {
        bindable(of: \.rowHeight, key: &rowHeightKey)
    }
    
    var sectionHeaderHeight: Observable<CGFloat> {
        bindable(of: \.sectionHeaderHeight, key: &sectionHeaderHeightKey)
    }
    
    var sectionFooterHeight: Observable<CGFloat> {
        bindable(of: \.sectionFooterHeight, key: &sectionFooterHeightKey)
    }
    
    var estimatedRowHeight: Observable<CGFloat> {
        bindable(of: \.estimatedRowHeight, key: &estimatedRowHeightKey)
    }
    
    var estimatedSectionHeaderHeight: Observable<CGFloat> {
        bindable(of: \.estimatedSectionHeaderHeight, key: &estimatedSectionHeaderHeightKey)
    }
    
    var estimatedSectionFooterHeight: Observable<CGFloat> {
        bindable(of: \.estimatedSectionFooterHeight, key: &estimatedSectionFooterHeightKey)
    }
    
    var separatorInset: Observable<UIEdgeInsets> {
        bindable(of: \.separatorInset, key: &separatorInsetKey)
    }
    
    var backgroundView: Observable<UIView?> {
        bindable(of: \.backgroundView, key: &backgroundViewKey)
    }
    
    var isEditing: Observable<Bool> {
        bindable(of: \.isEditing, key: &isEditingKey)
    }
    
    var allowsSelection: Observable<Bool> {
        bindable(of: \.allowsSelection, key: &allowsSelectionKey)
    }
    
    var allowsMultipleSelection: Observable<Bool> {
        bindable(of: \.allowsMultipleSelection, key: &allowsMultipleSelectionKey)
    }
    
    var sectionIndexMinimumDisplayRowCount: Observable<Int> {
        bindable(of: \.sectionIndexMinimumDisplayRowCount, key: &sectionIndexMinimumDisplayRowCountKey)
    }
    
    var sectionIndexColor: Observable<UIColor?> {
        bindable(of: \.sectionIndexColor, key: &sectionIndexColorKey)
    }
    
    var sectionIndexBackgroundColor: Observable<UIColor?> {
        bindable(of: \.sectionIndexBackgroundColor, key: &sectionIndexBackgroundColorKey)
    }
    
    var sectionIndexTrackingBackgroundColor: Observable<UIColor?> {
        bindable(of: \.sectionIndexTrackingBackgroundColor, key: &sectionIndexTrackingBackgroundColorKey)
    }
    
    var separatorStyle: Observable<UITableViewCell.SeparatorStyle> {
        bindable(of: \.separatorStyle, key: &separatorStyleKey)
    }
    
    var separatorColor: Observable<UIColor?> {
        bindable(of: \.separatorColor, key: &separatorColorKey)
    }
    
    var separatorEffect: Observable<UIVisualEffect?> {
        bindable(of: \.separatorEffect, key: &separatorEffectKey)
    }
    
    var cellLayoutMarginsFollowReadableWidth: Observable<Bool> {
        bindable(of: \.cellLayoutMarginsFollowReadableWidth, key: &cellLayoutMarginsFollowReadableWidthKey)
    }
    
    @available(iOS 11.0, *)
    var insetsContentViewsToSafeArea: Observable<Bool> {
        bindable(of: \.insetsContentViewsToSafeArea, key: &insetsContentViewsToSafeAreaKey)
    }
    
    var tableHeaderView: Observable<UIView?> {
        bindable(of: \.tableHeaderView, key: &tableHeaderViewKey)
    }
    
    var tableFooterView: Observable<UIView?> {
        bindable(of: \.tableFooterView, key: &tableFooterViewKey)
    }
    
    var remembersLastFocusedIndexPath: Observable<Bool> {
        bindable(of: \.remembersLastFocusedIndexPath, key: &remembersLastFocusedIndexPathKey)
    }
    
    @available(iOS 14.0, *)
    var selectionFollowsFocus: Observable<Bool> {
        bindable(of: \.selectionFollowsFocus, key: &selectionFollowsFocusKey)
    }
    
    @available(iOS 11.0, *)
    var dragInteractionEnabled: Observable<Bool> {
        bindable(of: \.dragInteractionEnabled, key: &dragInteractionEnabledKey)
    }
    
}
#endif
