//
//  RelayCollection+UIButton.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UIButton: PopulatedRelays {
    public typealias BaseRelayObject = UIButton
}

public extension RelayCollection where Object: UIButton {
    
    // MARK: Two Way Relay
    
    var contentEdgeInsets: TwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.contentEdgeInsets)
    }
    
    var titleEdgeInsets: TwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.titleEdgeInsets)
    }
    
    var reversesTitleShadowWhenHighlighted: TwoWayRelay<Bool> {
        .relay(of: object, \.reversesTitleShadowWhenHighlighted)
    }
    
    var imageEdgeInsets: TwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.imageEdgeInsets)
    }
    
    var adjustsImageWhenHighlighted: TwoWayRelay<Bool> {
        .relay(of: object, \.adjustsImageWhenHighlighted)
    }
    
    var adjustsImageWhenDisabled: TwoWayRelay<Bool> {
        .relay(of: object, \.adjustsImageWhenDisabled)
    }
    
    var showsTouchWhenHighlighted: TwoWayRelay<Bool> {
        .relay(of: object, \.showsTouchWhenHighlighted)
    }
    
    @available(iOS 14.0, *)
    var role: TwoWayRelay<UIButton.Role> {
        .relay(of: object, \.role)
    }
    
    @available(iOS 13.4, *)
    var isPointerInteractionEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isPointerInteractionEnabled)
    }
    
    @available(iOS 14.0, *)
    var menu: TwoWayRelay<UIMenu?> {
        .relay(of: object, \.menu)
    }
    
    // MARK: Value Relay
    
    var buttonType: ValueRelay<UIButton.ButtonType> {
        .relay(of: object, \.buttonType)
    }
    
    var currentTitle: ValueRelay<String?> {
        .relay(of: object, \.currentTitle)
    }
    
    var currentTitleColor: ValueRelay<UIColor> {
        .relay(of: object, \.currentTitleColor)
    }
    
    var currentTitleShadowColor: ValueRelay<UIColor?> {
        .relay(of: object, \.currentTitleShadowColor)
    }
    
    var currentImage: ValueRelay<UIImage?> {
        .relay(of: object, \.currentImage)
    }
    
    var currentBackgroundImage: ValueRelay<UIImage?> {
        .relay(of: object, \.currentBackgroundImage)
    }
    
    @available(iOS 13.0, *)
    var currentPreferredSymbolConfiguration: ValueRelay<UIImage.SymbolConfiguration?> {
        .relay(of: object, \.currentPreferredSymbolConfiguration)
    }
    
    var currentAttributedTitle: ValueRelay<NSAttributedString?> {
        .relay(of: object, \.currentAttributedTitle)
    }
    
    var titleLabel: ValueRelay<UILabel?> {
        .relay(of: object, \.titleLabel)
    }
    
    var imageView: ValueRelay<UIImageView?> {
        .relay(of: object, \.imageView)
    }
    
}
#endif
