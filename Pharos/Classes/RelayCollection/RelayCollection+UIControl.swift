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
    
    var isEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isEnabled)
    }
    
    var isSelected: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isSelected)
    }
    
    var isHighlighted: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isHighlighted)
    }
    
    var contentVerticalAlignment: AssociativeTwoWayRelay<UIControl.ContentVerticalAlignment> {
        .relay(of: underlyingObject, \.contentVerticalAlignment)
    }
    
    var contentHorizontalAlignment: AssociativeTwoWayRelay<UIControl.ContentHorizontalAlignment> {
        .relay(of: underlyingObject, \.contentHorizontalAlignment)
    }
    
    @available(iOS 14.0, *)
    var showsMenuAsPrimaryAction: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.showsMenuAsPrimaryAction)
    }
}
#endif
