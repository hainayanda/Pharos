//
//  BindableCollection+CellView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: UITableViewCell

fileprivate var automaticallyUpdatesContentConfigurationKey: String = "automaticallyUpdatesContentConfigurationKey"
fileprivate var automaticallyUpdatesBackgroundConfigurationKey: String = "automaticallyUpdatesBackgroundConfigurationKey"
fileprivate var backgroundViewKey: String = "backgroundViewKey"
fileprivate var selectedBackgroundViewKey: String = "selectedBackgroundViewKey"
fileprivate var multipleSelectionBackgroundViewKey: String = "multipleSelectionBackgroundViewKey"
fileprivate var isSelectedKey: String = "isSelectedKey"
fileprivate var isHighlightedKey: String = "isHighlightedKey"
fileprivate var showsReorderControlKey: String = "showsReorderControlKey"
fileprivate var shouldIndentWhileEditingKey: String = "shouldIndentWhileEditingKey"
fileprivate var accessoryViewKey: String = "accessoryViewKey"
fileprivate var editingAccessoryViewKey: String = "editingAccessoryViewKey"
fileprivate var indentationLevelKey: String = "indentationLevelKey"
fileprivate var indentationWidthKey: String = "indentationWidthKey"
fileprivate var isEditingKey: String = "isEditingKey"
fileprivate var userInteractionEnabledWhileDraggingKey: String = "userInteractionEnabledWhileDraggingKey"

public extension BindableCollection where Object: UITableViewCell {
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: BindableObservable<Bool> {
        bindable(of: \.automaticallyUpdatesContentConfiguration, key: &automaticallyUpdatesContentConfigurationKey)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: BindableObservable<Bool> {
        bindable(of: \.automaticallyUpdatesBackgroundConfiguration, key: &automaticallyUpdatesBackgroundConfigurationKey)
    }
    
    var backgroundView: BindableObservable<UIView?> {
        bindable(of: \.backgroundView, key: &backgroundViewKey)
    }
    
    var selectedBackgroundView: BindableObservable<UIView?> {
        bindable(of: \.selectedBackgroundView, key: &selectedBackgroundViewKey)
    }
    
    var multipleSelectionBackgroundView: BindableObservable<UIView?> {
        bindable(of: \.multipleSelectionBackgroundView, key: &multipleSelectionBackgroundViewKey)
    }
    
    var isSelected: BindableObservable<Bool> {
        bindable(of: \.isSelected, key: &isSelectedKey)
    }
    
    var isHighlighted: BindableObservable<Bool> {
        bindable(of: \.isHighlighted, key: &isHighlightedKey)
    }
    
    var showsReorderControl: BindableObservable<Bool> {
        bindable(of: \.showsReorderControl, key: &showsReorderControlKey)
    }
    
    var shouldIndentWhileEditing: BindableObservable<Bool> {
        bindable(of: \.shouldIndentWhileEditing, key: &shouldIndentWhileEditingKey)
    }
    
    var accessoryView: BindableObservable<UIView?> {
        bindable(of: \.accessoryView, key: &accessoryViewKey)
    }
    
    var editingAccessoryView: BindableObservable<UIView?> {
        bindable(of: \.editingAccessoryView, key: &editingAccessoryViewKey)
    }
    
    var indentationLevel: BindableObservable<Int> {
        bindable(of: \.indentationLevel, key: &indentationLevelKey)
    }
    
    var indentationWidth: BindableObservable<CGFloat> {
        bindable(of: \.indentationWidth, key: &indentationWidthKey)
    }
    
    var isEditing: BindableObservable<Bool> {
        bindable(of: \.isEditing, key: &isEditingKey)
    }
    
    @available(iOS 11.0, *)
    var userInteractionEnabledWhileDragging: BindableObservable<Bool> {
        bindable(of: \.userInteractionEnabledWhileDragging, key: &userInteractionEnabledWhileDraggingKey)
    }
}

// MARK: UICollectionViewCell

public extension BindableCollection where Object: UICollectionViewCell {
    
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: BindableObservable<Bool> {
        bindable(of: \.automaticallyUpdatesContentConfiguration, key: &automaticallyUpdatesContentConfigurationKey)
    }
    
    var isSelected: BindableObservable<Bool> {
        bindable(of: \.isSelected, key: &isSelectedKey)
    }
    
    var isHighlighted: BindableObservable<Bool> {
        bindable(of: \.isHighlighted, key: &isHighlightedKey)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: BindableObservable<Bool> {
        bindable(of: \.automaticallyUpdatesBackgroundConfiguration, key: &automaticallyUpdatesBackgroundConfigurationKey)
    }
    
    var backgroundView: BindableObservable<UIView?> {
        bindable(of: \.backgroundView, key: &backgroundViewKey)
    }
    
    var selectedBackgroundView: BindableObservable<UIView?> {
        bindable(of: \.selectedBackgroundView, key: &selectedBackgroundViewKey)
    }
    
}
#endif

