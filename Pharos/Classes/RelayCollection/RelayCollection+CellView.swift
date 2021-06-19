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
        .relay(of: object, \.automaticallyUpdatesContentConfiguration)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.automaticallyUpdatesBackgroundConfiguration)
    }
    
    var backgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.backgroundView)
    }
    
    var selectedBackgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.selectedBackgroundView)
    }
    
    var multipleSelectionBackgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.multipleSelectionBackgroundView)
    }
    
    var isSelected: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isSelected)
    }
    
    var isHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isHighlighted)
    }
    
    var showsReorderControl: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.showsReorderControl)
    }
    
    var shouldIndentWhileEditing: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.shouldIndentWhileEditing)
    }
    
    var accessoryView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.accessoryView)
    }
    
    var editingAccessoryView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.editingAccessoryView)
    }
    
    var indentationLevel: AssociativeTwoWayRelay<Int> {
        .relay(of: object, \.indentationLevel)
    }
    
    var indentationWidth: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: object, \.indentationWidth)
    }
    
    var isEditing: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isEditing)
    }
    
    @available(iOS 11.0, *)
    var userInteractionEnabledWhileDragging: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.userInteractionEnabledWhileDragging)
    }
}

// MARK: UICollectionViewCell

public extension RelayCollection where Object: UICollectionViewCell {
    
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.automaticallyUpdatesContentConfiguration)
    }
    
    var isSelected: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isSelected)
    }
    
    var isHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isHighlighted)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.automaticallyUpdatesBackgroundConfiguration)
    }
    
    var backgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.backgroundView)
    }
    
    var selectedBackgroundView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.selectedBackgroundView)
    }
    
}
#endif

