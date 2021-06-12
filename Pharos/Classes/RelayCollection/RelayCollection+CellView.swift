//
//  RelayCollection+CellView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: UITableViewCell

extension UITableViewCell: PopulatedRelays {
    public typealias BaseRelayObject = UITableViewCell
}

public extension RelayCollection where Object: UITableViewCell {
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: TwoWayRelay<Bool> {
        .relay(of: object, \.automaticallyUpdatesContentConfiguration)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: TwoWayRelay<Bool> {
        .relay(of: object, \.automaticallyUpdatesBackgroundConfiguration)
    }
    
    var backgroundView: TwoWayRelay<UIView?> {
        .relay(of: object, \.backgroundView)
    }
    
    var selectedBackgroundView: TwoWayRelay<UIView?> {
        .relay(of: object, \.selectedBackgroundView)
    }
    
    var multipleSelectionBackgroundView: TwoWayRelay<UIView?> {
        .relay(of: object, \.multipleSelectionBackgroundView)
    }
    
    var selectionStyle: TwoWayRelay<UITableViewCell.SelectionStyle> {
        .relay(of: object, \.selectionStyle)
    }
    
    var isSelected: TwoWayRelay<Bool> {
        .relay(of: object, \.isSelected)
    }
    
    var isHighlighted: TwoWayRelay<Bool> {
        .relay(of: object, \.isHighlighted)
    }
    
    var showsReorderControl: TwoWayRelay<Bool> {
        .relay(of: object, \.showsReorderControl)
    }
    
    var shouldIndentWhileEditing: TwoWayRelay<Bool> {
        .relay(of: object, \.shouldIndentWhileEditing)
    }
    
    var accessoryType: TwoWayRelay<UITableViewCell.AccessoryType> {
        .relay(of: object, \.accessoryType)
    }
    
    var accessoryView: TwoWayRelay<UIView?> {
        .relay(of: object, \.accessoryView)
    }
    
    var editingAccessoryType: TwoWayRelay<UITableViewCell.AccessoryType> {
        .relay(of: object, \.editingAccessoryType)
    }
    
    var editingAccessoryView: TwoWayRelay<UIView?> {
        .relay(of: object, \.editingAccessoryView)
    }
    
    var indentationLevel: TwoWayRelay<Int> {
        .relay(of: object, \.indentationLevel)
    }
    
    var indentationWidth: TwoWayRelay<CGFloat> {
        .relay(of: object, \.indentationWidth)
    }
    
    @available(iOS 7.0, *)
    var separatorInset: TwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.separatorInset)
    }
    
    var isEditing: TwoWayRelay<Bool> {
        .relay(of: object, \.isEditing)
    }
    
    @available(iOS 9.0, *)
    var focusStyle: TwoWayRelay<UITableViewCell.FocusStyle> {
        .relay(of: object, \.focusStyle)
    }
    
    @available(iOS 11.0, *)
    var userInteractionEnabledWhileDragging: TwoWayRelay<Bool> {
        .relay(of: object, \.userInteractionEnabledWhileDragging)
    }
    
    // MARK: Value Relay
    
    var contentView: ValueRelay<UIView> {
        .relay(of: object, \.contentView)
    }
    
    var reuseIdentifier: ValueRelay<String?> {
        .relay(of: object, \.reuseIdentifier)
    }
    
    var editingStyle: ValueRelay<UITableViewCell.EditingStyle> {
        .relay(of: object, \.editingStyle)
    }
    
    var showingDeleteConfirmation: ValueRelay<Bool> {
        .relay(of: object, \.showingDeleteConfirmation)
    }
}

// MARK: UICollectionViewCell

extension UICollectionViewCell: PopulatedRelays {
    public typealias BaseRelayObject = UICollectionViewCell
}

public extension RelayCollection where Object: UICollectionViewCell {
    
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: TwoWayRelay<Bool> {
        .relay(of: object, \.automaticallyUpdatesContentConfiguration)
    }
    
    var isSelected: TwoWayRelay<Bool> {
        .relay(of: object, \.isSelected)
    }
    
    var isHighlighted: TwoWayRelay<Bool> {
        .relay(of: object, \.isHighlighted)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: TwoWayRelay<Bool> {
        .relay(of: object, \.automaticallyUpdatesBackgroundConfiguration)
    }
    
    var backgroundView: TwoWayRelay<UIView?> {
        .relay(of: object, \.backgroundView)
    }
    
    var selectedBackgroundView: TwoWayRelay<UIView?> {
        .relay(of: object, \.selectedBackgroundView)
    }
    
    // MARK: Value Relay
    
    var contentView: ValueRelay<UIView> {
        .relay(of: object, \.contentView)
    }
    
}
#endif

