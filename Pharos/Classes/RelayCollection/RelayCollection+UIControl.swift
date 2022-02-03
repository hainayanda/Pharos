//
//  RelayCollection+UIControl.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UIControl {
    
    // MARK: Two Way Relay
    
    var isEnabled: BindableRelay<Bool> {
        bindable(of:\.isEnabled)
    }
    
    var isSelected: BindableRelay<Bool> {
        bindable(of:\.isSelected)
    }
    
    var isHighlighted: BindableRelay<Bool> {
        bindable(of:\.isHighlighted)
    }
    
    var contentVerticalAlignment: BindableRelay<UIControl.ContentVerticalAlignment> {
        bindable(of:\.contentVerticalAlignment)
    }
    
    var contentHorizontalAlignment: BindableRelay<UIControl.ContentHorizontalAlignment> {
        bindable(of:\.contentHorizontalAlignment)
    }
    
    @available(iOS 14.0, *)
    var showsMenuAsPrimaryAction: BindableRelay<Bool> {
        bindable(of:\.showsMenuAsPrimaryAction)
    }
}
#endif
