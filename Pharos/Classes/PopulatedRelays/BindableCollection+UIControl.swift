//
//  RelayCollection+UIControl.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

fileprivate var isEnabledKey: String = "isEnabledKey"
fileprivate var isSelectedKey: String = "isSelectedKey"
fileprivate var isHighlightedKey: String = "isHighlightedKey"
fileprivate var contentVerticalAlignmentKey: String = "contentVerticalAlignmentKey"
fileprivate var contentHorizontalAlignmentKey: String = "contentHorizontalAlignmentKey"
fileprivate var showsMenuAsPrimaryActionKey: String = "showsMenuAsPrimaryActionKey"

public extension BindableCollection where Object: UIControl {
    
    // MARK: Two Way Relay
    
    var isEnabled: BindableObservable<Bool> {
        bindable(of: \.isEnabled, key: &isEnabledKey)
    }
    
    var isSelected: BindableObservable<Bool> {
        bindable(of: \.isSelected, key: &isSelectedKey)
    }
    
    var isHighlighted: BindableObservable<Bool> {
        bindable(of: \.isHighlighted, key: &isHighlightedKey)
    }
    
    var contentVerticalAlignment: BindableObservable<UIControl.ContentVerticalAlignment> {
        bindable(of: \.contentVerticalAlignment, key: &contentVerticalAlignmentKey)
    }
    
    var contentHorizontalAlignment: BindableObservable<UIControl.ContentHorizontalAlignment> {
        bindable(of: \.contentHorizontalAlignment, key: &contentHorizontalAlignmentKey)
    }
    
    @available(iOS 14.0, *)
    var showsMenuAsPrimaryAction: BindableObservable<Bool> {
        bindable(of: \.showsMenuAsPrimaryAction, key: &showsMenuAsPrimaryActionKey)
    }
}
#endif
