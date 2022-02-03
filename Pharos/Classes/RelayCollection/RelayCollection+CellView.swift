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
    var automaticallyUpdatesContentConfiguration: BindableRelay<Bool> {
        bindable(of:\.automaticallyUpdatesContentConfiguration)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: BindableRelay<Bool> {
        bindable(of:\.automaticallyUpdatesBackgroundConfiguration)
    }
    
    var backgroundView: BindableRelay<UIView?> {
        bindable(of:\.backgroundView)
    }
    
    var selectedBackgroundView: BindableRelay<UIView?> {
        bindable(of:\.selectedBackgroundView)
    }
    
    var multipleSelectionBackgroundView: BindableRelay<UIView?> {
        bindable(of:\.multipleSelectionBackgroundView)
    }
    
    var isSelected: BindableRelay<Bool> {
        bindable(of:\.isSelected)
    }
    
    var isHighlighted: BindableRelay<Bool> {
        bindable(of:\.isHighlighted)
    }
    
    var showsReorderControl: BindableRelay<Bool> {
        bindable(of:\.showsReorderControl)
    }
    
    var shouldIndentWhileEditing: BindableRelay<Bool> {
        bindable(of:\.shouldIndentWhileEditing)
    }
    
    var accessoryView: BindableRelay<UIView?> {
        bindable(of:\.accessoryView)
    }
    
    var editingAccessoryView: BindableRelay<UIView?> {
        bindable(of:\.editingAccessoryView)
    }
    
    var indentationLevel: BindableRelay<Int> {
        bindable(of:\.indentationLevel)
    }
    
    var indentationWidth: BindableRelay<CGFloat> {
        bindable(of:\.indentationWidth)
    }
    
    var isEditing: BindableRelay<Bool> {
        bindable(of:\.isEditing)
    }
    
    @available(iOS 11.0, *)
    var userInteractionEnabledWhileDragging: BindableRelay<Bool> {
        bindable(of:\.userInteractionEnabledWhileDragging)
    }
}

// MARK: UICollectionViewCell

public extension RelayCollection where Object: UICollectionViewCell {
    
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: BindableRelay<Bool> {
        bindable(of:\.automaticallyUpdatesContentConfiguration)
    }
    
    var isSelected: BindableRelay<Bool> {
        bindable(of:\.isSelected)
    }
    
    var isHighlighted: BindableRelay<Bool> {
        bindable(of:\.isHighlighted)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: BindableRelay<Bool> {
        bindable(of:\.automaticallyUpdatesBackgroundConfiguration)
    }
    
    var backgroundView: BindableRelay<UIView?> {
        bindable(of:\.backgroundView)
    }
    
    var selectedBackgroundView: BindableRelay<UIView?> {
        bindable(of:\.selectedBackgroundView)
    }
    
}
#endif

