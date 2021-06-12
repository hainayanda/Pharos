//
//  RelayCollection+UIControl.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension UIControl {
    var controlRelays: RelayCollection<UIControl> {
        .init(object: self)
    }
}

public extension RelayCollection where Object: UIControl {
    
    // MARK: Two Way Relay
    
    var isEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isEnabled)
    }
    
    var isSelected: TwoWayRelay<Bool> {
        .relay(of: object, \.isSelected)
    }
    
    var isHighlighted: TwoWayRelay<Bool> {
        .relay(of: object, \.isHighlighted)
    }
    
    var contentVerticalAlignment: TwoWayRelay<UIControl.ContentVerticalAlignment> {
        .relay(of: object, \.contentVerticalAlignment)
    }
    
    var contentHorizontalAlignment: TwoWayRelay<UIControl.ContentHorizontalAlignment> {
        .relay(of: object, \.contentHorizontalAlignment)
    }
    
    @available(iOS 14.0, *)
    var isContextMenuInteractionEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isContextMenuInteractionEnabled)
    }
    
    @available(iOS 14.0, *)
    var showsMenuAsPrimaryAction: TwoWayRelay<Bool> {
        .relay(of: object, \.showsMenuAsPrimaryAction)
    }
    
    // MARK: Value Relay
    
    var effectiveContentHorizontalAlignment: ValueRelay<UIControl.ContentHorizontalAlignment> {
        .relay(of: object, \.effectiveContentHorizontalAlignment)
    }
    
    var state: ValueRelay<UIControl.State> {
        .relay(of: object, \.state)
    }
    
    var isTracking: ValueRelay<Bool> {
        .relay(of: object, \.isTracking)
    }
    
    var isTouchInside: ValueRelay<Bool> {
        .relay(of: object, \.isTouchInside)
    }
    
    var allTargets: ValueRelay<Set<AnyHashable>> {
        .relay(of: object, \.allTargets)
    }
    
    var allControlEvents: ValueRelay<UIControl.Event> {
        .relay(of: object, \.allControlEvents)
    }
    
    @available(iOS 14.0, *)
    var contextMenuInteraction: ValueRelay<UIContextMenuInteraction?> {
        .relay(of: object, \.contextMenuInteraction)
    }
}
#endif
