//
//  RelayCollection+UIView.swift
//  Pharos
//
//  Created by Nayanda Haberty on 13/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UIView {
    
    // MARK: Two Way Relay

    var isUserInteractionEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isUserInteractionEnabled)
    }
    
    var tag: AssociativeTwoWayRelay<Int> {
        .relay(of: underlyingObject, \.tag)
    }
    
    @available(iOS 14.0, *)
    var focusGroupIdentifier: AssociativeTwoWayRelay<String?> {
        .relay(of: underlyingObject, \.focusGroupIdentifier)
    }
    
    var frame: AssociativeTwoWayRelay<CGRect> {
        .relay(of: underlyingObject, \.frame)
    }
    
    var bounds: AssociativeTwoWayRelay<CGRect> {
        .relay(of: underlyingObject, \.bounds)
    }
    
    var center: AssociativeTwoWayRelay<CGPoint> {
        .relay(of: underlyingObject, \.center)
    }
    
    var contentScaleFactor: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.contentScaleFactor)
    }
    
    var isMultipleTouchEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isMultipleTouchEnabled)
    }
    
    var isExclusiveTouch: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isExclusiveTouch)
    }

    var autoresizesSubviews: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.autoresizesSubviews)
    }
    
    var layoutMargins: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: underlyingObject, \.layoutMargins)
    }
    
    @available(iOS 11.0, *)
    var directionalLayoutMargins: AssociativeTwoWayRelay<NSDirectionalEdgeInsets> {
        .relay(of: underlyingObject, \.directionalLayoutMargins)
    }
    
    var preservesSuperviewLayoutMargins: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.preservesSuperviewLayoutMargins)
    }
    
    @available(iOS 11.0, *)
    var insetsLayoutMarginsFromSafeArea: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.insetsLayoutMarginsFromSafeArea)
    }
    
    var clipsToBounds: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.clipsToBounds)
    }
    
    var backgroundColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.backgroundColor)
    }
    
    var alpha: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.alpha)
    }
    
    var isOpaque: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isOpaque)
    }
    
    var clearsContextBeforeDrawing: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.clearsContextBeforeDrawing)
    }
    
    var isHidden: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isHidden)
    }
    
    var mask: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.mask)
    }
    
    var tintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.tintColor)
    }
    
    var translatesAutoresizingMaskIntoConstraints: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.translatesAutoresizingMaskIntoConstraints)
    }
    
    var restorationIdentifier: AssociativeTwoWayRelay<String?> {
        .relay(of: underlyingObject, \.restorationIdentifier)
    }
    
}
#endif
