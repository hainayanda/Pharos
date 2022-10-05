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

// swiftlint:disable:next identifier_name
private var automaticallyUpdatesContentConfigurationKey: String = "automaticallyUpdatesContentConfigurationKey"
// swiftlint:disable:next identifier_name
private var automaticallyUpdatesBackgroundConfigurationKey: String = "automaticallyUpdatesBackgroundConfigurationKey"
private var backgroundViewKey: String = "backgroundViewKey"
private var selectedBackgroundViewKey: String = "selectedBackgroundViewKey"
private var multipleSelectionBackgroundViewKey: String = "multipleSelectionBackgroundViewKey"
private var isSelectedKey: String = "isSelectedKey"
private var isHighlightedKey: String = "isHighlightedKey"
private var showsReorderControlKey: String = "showsReorderControlKey"
private var shouldIndentWhileEditingKey: String = "shouldIndentWhileEditingKey"
private var accessoryViewKey: String = "accessoryViewKey"
private var editingAccessoryViewKey: String = "editingAccessoryViewKey"
private var indentationLevelKey: String = "indentationLevelKey"
private var indentationWidthKey: String = "indentationWidthKey"
private var isEditingKey: String = "isEditingKey"
private var userInteractionEnabledWhileDraggingKey: String = "userInteractionEnabledWhileDraggingKey"

public extension BindableCollection where Object: UITableViewCell {
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: Observable<Bool> {
        bindable(of: \.automaticallyUpdatesContentConfiguration, key: &automaticallyUpdatesContentConfigurationKey)
    }
    
    @available(iOS 14.0, *)
    // swiftlint:disable:next identifier_name
    var automaticallyUpdatesBackgroundConfiguration: Observable<Bool> {
        bindable(of: \.automaticallyUpdatesBackgroundConfiguration, key: &automaticallyUpdatesBackgroundConfigurationKey)
    }
    
    var backgroundView: Observable<UIView?> {
        bindable(of: \.backgroundView, key: &backgroundViewKey)
    }
    
    var selectedBackgroundView: Observable<UIView?> {
        bindable(of: \.selectedBackgroundView, key: &selectedBackgroundViewKey)
    }
    
    var multipleSelectionBackgroundView: Observable<UIView?> {
        bindable(of: \.multipleSelectionBackgroundView, key: &multipleSelectionBackgroundViewKey)
    }
    
    var isSelected: Observable<Bool> {
        bindable(of: \.isSelected, key: &isSelectedKey)
    }
    
    var isHighlighted: Observable<Bool> {
        bindable(of: \.isHighlighted, key: &isHighlightedKey)
    }
    
    var showsReorderControl: Observable<Bool> {
        bindable(of: \.showsReorderControl, key: &showsReorderControlKey)
    }
    
    var shouldIndentWhileEditing: Observable<Bool> {
        bindable(of: \.shouldIndentWhileEditing, key: &shouldIndentWhileEditingKey)
    }
    
    var accessoryView: Observable<UIView?> {
        bindable(of: \.accessoryView, key: &accessoryViewKey)
    }
    
    var editingAccessoryView: Observable<UIView?> {
        bindable(of: \.editingAccessoryView, key: &editingAccessoryViewKey)
    }
    
    var indentationLevel: Observable<Int> {
        bindable(of: \.indentationLevel, key: &indentationLevelKey)
    }
    
    var indentationWidth: Observable<CGFloat> {
        bindable(of: \.indentationWidth, key: &indentationWidthKey)
    }
    
    var isEditing: Observable<Bool> {
        bindable(of: \.isEditing, key: &isEditingKey)
    }
    
    @available(iOS 11.0, *)
    var userInteractionEnabledWhileDragging: Observable<Bool> {
        bindable(of: \.userInteractionEnabledWhileDragging, key: &userInteractionEnabledWhileDraggingKey)
    }
}

// MARK: UICollectionViewCell

public extension BindableCollection where Object: UICollectionViewCell {
    
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: Observable<Bool> {
        bindable(of: \.automaticallyUpdatesContentConfiguration, key: &automaticallyUpdatesContentConfigurationKey)
    }
    
    var isSelected: Observable<Bool> {
        bindable(of: \.isSelected, key: &isSelectedKey)
    }
    
    var isHighlighted: Observable<Bool> {
        bindable(of: \.isHighlighted, key: &isHighlightedKey)
    }
    
    @available(iOS 14.0, *)
    // swiftlint:disable:next identifier_name
    var automaticallyUpdatesBackgroundConfiguration: Observable<Bool> {
        bindable(of: \.automaticallyUpdatesBackgroundConfiguration, key: &automaticallyUpdatesBackgroundConfigurationKey)
    }
    
    var backgroundView: Observable<UIView?> {
        bindable(of: \.backgroundView, key: &backgroundViewKey)
    }
    
    var selectedBackgroundView: Observable<UIView?> {
        bindable(of: \.selectedBackgroundView, key: &selectedBackgroundViewKey)
    }
    
}
#endif
