//
//  RelayCollection+UIView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension UIView {
    var viewRelays: RelayCollection<UIView> {
        .init(object: self)
    }
}

public extension RelayCollection where Object: UIView {
    
    // MARK: Two Way Relay

    var isUserInteractionEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isUserInteractionEnabled)
    }
    
    var tag: TwoWayRelay<Int> {
        .relay(of: object, \.tag)
    }
    
    @available(iOS 14.0, *)
    var focusGroupIdentifier: TwoWayRelay<String?> {
        .relay(of: object, \.focusGroupIdentifier)
    }
    
    var semanticContentAttribute: TwoWayRelay<UISemanticContentAttribute> {
        .relay(of: object, \.semanticContentAttribute)
    }
    
    var frame: TwoWayRelay<CGRect> {
        .relay(of: object, \.frame)
    }
    
    var bounds: TwoWayRelay<CGRect> {
        .relay(of: object, \.bounds)
    }
    
    var center: TwoWayRelay<CGPoint> {
        .relay(of: object, \.center)
    }
    
    var transform: TwoWayRelay<CGAffineTransform> {
        .relay(of: object, \.transform)
    }
    
    @available(iOS 13.0, *)
    var transform3D: TwoWayRelay<CATransform3D> {
        .relay(of: object, \.transform3D)
    }
    
    var contentScaleFactor: TwoWayRelay<CGFloat> {
        .relay(of: object, \.contentScaleFactor)
    }
    
    var isMultipleTouchEnabled: TwoWayRelay<Bool> {
        .relay(of: object, \.isMultipleTouchEnabled)
    }
    
    var isExclusiveTouch: TwoWayRelay<Bool> {
        .relay(of: object, \.isExclusiveTouch)
    }

    var autoresizesSubviews: TwoWayRelay<Bool> {
        .relay(of: object, \.autoresizesSubviews)
    }
    
    var autoresizingMask: TwoWayRelay<UIView.AutoresizingMask> {
        .relay(of: object, \.autoresizingMask)
    }
    
    var layoutMargins: TwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.layoutMargins)
    }
    
    @available(iOS 11.0, *)
    var directionalLayoutMargins: TwoWayRelay<NSDirectionalEdgeInsets> {
        .relay(of: object, \.directionalLayoutMargins)
    }
    
    var preservesSuperviewLayoutMargins: TwoWayRelay<Bool> {
        .relay(of: object, \.preservesSuperviewLayoutMargins)
    }
    
    @available(iOS 11.0, *)
    var insetsLayoutMarginsFromSafeArea: TwoWayRelay<Bool> {
        .relay(of: object, \.insetsLayoutMarginsFromSafeArea)
    }
    
    var clipsToBounds: TwoWayRelay<Bool> {
        .relay(of: object, \.clipsToBounds)
    }
    
    var backgroundColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.backgroundColor)
    }
    
    var alpha: TwoWayRelay<CGFloat> {
        .relay(of: object, \.alpha)
    }
    
    var isOpaque: TwoWayRelay<Bool> {
        .relay(of: object, \.isOpaque)
    }
    
    var clearsContextBeforeDrawing: TwoWayRelay<Bool> {
        .relay(of: object, \.clearsContextBeforeDrawing)
    }
    
    var isHidden: TwoWayRelay<Bool> {
        .relay(of: object, \.isHidden)
    }
    
    var contentMode: TwoWayRelay<UIView.ContentMode> {
        .relay(of: object, \.contentMode)
    }
    
    var mask: TwoWayRelay<UIView?> {
        .relay(of: object, \.mask)
    }
    
    var tintColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.tintColor)
    }
    
    var tintAdjustmentMode: TwoWayRelay<UIView.TintAdjustmentMode> {
        .relay(of: object, \.tintAdjustmentMode)
    }
    
    var motionEffects: TwoWayRelay<[UIMotionEffect]> {
        .relay(of: object, \.motionEffects)
    }
    
    var translatesAutoresizingMaskIntoConstraints: TwoWayRelay<Bool> {
        .relay(of: object, \.translatesAutoresizingMaskIntoConstraints)
    }
    
    var restorationIdentifier: TwoWayRelay<String?> {
        .relay(of: object, \.restorationIdentifier)
    }
    
    // MARK: Value Relay
    
    var layer: ValueRelay<CALayer> {
        .relay(of: object, \.layer)
    }
    
    var canBecomeFocused: ValueRelay<Bool> {
        .relay(of: object, \.canBecomeFocused)
    }
    
    var isFocused: ValueRelay<Bool> {
        .relay(of: object, \.isFocused)
    }
    
    var effectiveUserInterfaceLayoutDirection: ValueRelay<UIUserInterfaceLayoutDirection> {
        .relay(of: object, \.effectiveUserInterfaceLayoutDirection)
    }
    
    var superview: ValueRelay<UIView?> {
        .relay(of: object, \.superview)
    }
    
    var subviews: ValueRelay<[UIView]> {
        .relay(of: object, \.subviews)
    }
    
    var window: ValueRelay<UIWindow?> {
        .relay(of: object, \.window)
    }
    
    @available(iOS 11.0, *)
    var safeAreaInsets: ValueRelay<UIEdgeInsets> {
        .relay(of: object, \.safeAreaInsets)
    }
    
    var layoutMarginsGuide: ValueRelay<UILayoutGuide> {
        .relay(of: object, \.layoutMarginsGuide)
    }
    
    var readableContentGuide: ValueRelay<UILayoutGuide> {
        .relay(of: object, \.readableContentGuide)
    }
    
    @available(iOS 11.0, *)
    var safeAreaLayoutGuide: ValueRelay<UILayoutGuide> {
        .relay(of: object, \.safeAreaLayoutGuide)
    }
    
    var constraints: ValueRelay<[NSLayoutConstraint]> {
        .relay(of: object, \.constraints)
    }
    
    var alignmentRectInsets: ValueRelay<UIEdgeInsets> {
        .relay(of: object, \.alignmentRectInsets)
    }
    
    var forFirstBaselineLayout: ValueRelay<UIView> {
        .relay(of: object, \.forFirstBaselineLayout)
    }
    
    var forLastBaselineLayout: ValueRelay<UIView> {
        .relay(of: object, \.forLastBaselineLayout)
    }
    
    var intrinsicContentSize: ValueRelay<CGSize> {
        .relay(of: object, \.intrinsicContentSize)
    }
    
    var layoutGuides: ValueRelay<[UILayoutGuide]> {
        .relay(of: object, \.layoutGuides)
    }
    
    var hasAmbiguousLayout: ValueRelay<Bool> {
        .relay(of: object, \.hasAmbiguousLayout)
    }
    
    @available(iOS 13.0, *)
    var overrideUserInterfaceStyle: ValueRelay<UIUserInterfaceStyle> {
        .relay(of: object, \.overrideUserInterfaceStyle)
    }
    
}
#endif
