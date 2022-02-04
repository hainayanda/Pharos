//
//  RelayCollection+UIControl.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UIControl {
    
    // MARK: Two Way Relay
    
    var isEnabled: BindableObservable<Bool> {
        bindable(of:\.isEnabled)
    }
    
    var isSelected: BindableObservable<Bool> {
        bindable(of:\.isSelected)
    }
    
    var isHighlighted: BindableObservable<Bool> {
        bindable(of:\.isHighlighted)
    }
    
    var contentVerticalAlignment: BindableObservable<UIControl.ContentVerticalAlignment> {
        bindable(of:\.contentVerticalAlignment)
    }
    
    var contentHorizontalAlignment: BindableObservable<UIControl.ContentHorizontalAlignment> {
        bindable(of:\.contentHorizontalAlignment)
    }
    
    @available(iOS 14.0, *)
    var showsMenuAsPrimaryAction: BindableObservable<Bool> {
        bindable(of:\.showsMenuAsPrimaryAction)
    }
}
#endif
