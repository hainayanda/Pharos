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

public extension BindableCollection where Object: UITableViewCell {
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: BindableObservable<Bool> {
        bindable(of:\.automaticallyUpdatesContentConfiguration)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: BindableObservable<Bool> {
        bindable(of:\.automaticallyUpdatesBackgroundConfiguration)
    }
    
    var backgroundView: BindableObservable<UIView?> {
        bindable(of:\.backgroundView)
    }
    
    var selectedBackgroundView: BindableObservable<UIView?> {
        bindable(of:\.selectedBackgroundView)
    }
    
    var multipleSelectionBackgroundView: BindableObservable<UIView?> {
        bindable(of:\.multipleSelectionBackgroundView)
    }
    
    var isSelected: BindableObservable<Bool> {
        bindable(of:\.isSelected)
    }
    
    var isHighlighted: BindableObservable<Bool> {
        bindable(of:\.isHighlighted)
    }
    
    var showsReorderControl: BindableObservable<Bool> {
        bindable(of:\.showsReorderControl)
    }
    
    var shouldIndentWhileEditing: BindableObservable<Bool> {
        bindable(of:\.shouldIndentWhileEditing)
    }
    
    var accessoryView: BindableObservable<UIView?> {
        bindable(of:\.accessoryView)
    }
    
    var editingAccessoryView: BindableObservable<UIView?> {
        bindable(of:\.editingAccessoryView)
    }
    
    var indentationLevel: BindableObservable<Int> {
        bindable(of:\.indentationLevel)
    }
    
    var indentationWidth: BindableObservable<CGFloat> {
        bindable(of:\.indentationWidth)
    }
    
    var isEditing: BindableObservable<Bool> {
        bindable(of:\.isEditing)
    }
    
    @available(iOS 11.0, *)
    var userInteractionEnabledWhileDragging: BindableObservable<Bool> {
        bindable(of:\.userInteractionEnabledWhileDragging)
    }
}

// MARK: UICollectionViewCell

public extension BindableCollection where Object: UICollectionViewCell {
    
    // MARK: Two Way Relay
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesContentConfiguration: BindableObservable<Bool> {
        bindable(of:\.automaticallyUpdatesContentConfiguration)
    }
    
    var isSelected: BindableObservable<Bool> {
        bindable(of:\.isSelected)
    }
    
    var isHighlighted: BindableObservable<Bool> {
        bindable(of:\.isHighlighted)
    }
    
    @available(iOS 14.0, *)
    var automaticallyUpdatesBackgroundConfiguration: BindableObservable<Bool> {
        bindable(of:\.automaticallyUpdatesBackgroundConfiguration)
    }
    
    var backgroundView: BindableObservable<UIView?> {
        bindable(of:\.backgroundView)
    }
    
    var selectedBackgroundView: BindableObservable<UIView?> {
        bindable(of:\.selectedBackgroundView)
    }
    
}
#endif

