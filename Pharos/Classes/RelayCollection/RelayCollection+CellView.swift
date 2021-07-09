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

public extension RelayCollection where Object: UITableViewCell {
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.automaticallyUpdatesContentConfiguration)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.automaticallyUpdatesBackgroundConfiguration)
    }
    
    var backgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.backgroundView)
    }
    
    var selectedBackgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.selectedBackgroundView)
    }
    
    var multipleSelectionBackgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.multipleSelectionBackgroundView)
    }
    
    var isSelected: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isSelected)
    }
    
    var isHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isHighlighted)
    }
    
    var showsReorderControl: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.showsReorderControl)
    }
    
    var shouldIndentWhileEditing: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.shouldIndentWhileEditing)
    }
    
    var accessoryView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.accessoryView)
    }
    
    var editingAccessoryView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.editingAccessoryView)
    }
    
    var indentationLevel: AssociativeTwoWayRelay<Int> {
        .relay(of: underlyingObject, \.indentationLevel)
    }
    
    var indentationWidth: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.indentationWidth)
    }
    
    var isEditing: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isEditing)
    }
    
    @available(iOS 11.0, *)
    var userInteractionEnabledWhileDragging: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.userInteractionEnabledWhileDragging)
    }
}

// MARK: UICollectionViewCell

public extension RelayCollection where Object: UICollectionViewCell {
    
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.automaticallyUpdatesContentConfiguration)
    }
    
    var isSelected: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isSelected)
    }
    
    var isHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isHighlighted)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.automaticallyUpdatesBackgroundConfiguration)
    }
    
    var backgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.backgroundView)
    }
    
    var selectedBackgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.selectedBackgroundView)
    }
    
}
#endif

