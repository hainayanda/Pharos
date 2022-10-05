//
//  RelayCollection+UIControl.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

private var isEnabledKey: String = "isEnabledKey"
private var isSelectedKey: String = "isSelectedKey"
private var isHighlightedKey: String = "isHighlightedKey"
private var contentVerticalAlignmentKey: String = "contentVerticalAlignmentKey"
private var contentHorizontalAlignmentKey: String = "contentHorizontalAlignmentKey"
private var showsMenuAsPrimaryActionKey: String = "showsMenuAsPrimaryActionKey"

public extension BindableCollection where Object: UIControl {
    
    // MARK: Two Way Relay
    
    var isEnabled: Observable<Bool> {
        bindable(of: \.isEnabled, key: &isEnabledKey)
    }
    
    var isSelected: Observable<Bool> {
        bindable(of: \.isSelected, key: &isSelectedKey)
    }
    
    var isHighlighted: Observable<Bool> {
        bindable(of: \.isHighlighted, key: &isHighlightedKey)
    }
    
    var contentVerticalAlignment: Observable<UIControl.ContentVerticalAlignment> {
        bindable(of: \.contentVerticalAlignment, key: &contentVerticalAlignmentKey)
    }
    
    var contentHorizontalAlignment: Observable<UIControl.ContentHorizontalAlignment> {
        bindable(of: \.contentHorizontalAlignment, key: &contentHorizontalAlignmentKey)
    }
    
    @available(iOS 14.0, *)
    var showsMenuAsPrimaryAction: Observable<Bool> {
        bindable(of: \.showsMenuAsPrimaryAction, key: &showsMenuAsPrimaryActionKey)
    }
}
#endif
