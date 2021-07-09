//
//  RelayCollection+Scroll.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension RelayCollection where Object: UIScrollView {
    
    // MARK: Two Way Relay
    
    var contentOffset: AssociativeTwoWayRelay<CGPoint> {
        .relay(of: underlyingObject, \.contentOffset)
    }
    
    var contentSize: AssociativeTwoWayRelay<CGSize> {
        .relay(of: underlyingObject, \.contentSize)
    }
    
    var contentInset: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: underlyingObject, \.contentInset)
    }
    
    var delegate: AssociativeTwoWayRelay<UIScrollViewDelegate?> {
        .relay(of: underlyingObject, \.delegate)
    }
    
    var isDirectionalLockEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isDirectionalLockEnabled)
    }
    
    var bounces: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.bounces)
    }
    
    var alwaysBounceVertical: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.alwaysBounceVertical)
    }
    
    var alwaysBounceHorizontal: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.alwaysBounceHorizontal)
    }
    
    var isPagingEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isPagingEnabled)
    }
    
    var isScrollEnabled: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isScrollEnabled)
    }
    
    var showsVerticalScrollIndicator: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.showsVerticalScrollIndicator)
    }
    
    var showsHorizontalScrollIndicator: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.showsHorizontalScrollIndicator)
    }
    
    @available(iOS 11.1, *)
    var verticalScrollIndicatorInsets: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: underlyingObject, \.verticalScrollIndicatorInsets)
    }
    
    @available(iOS 11.1, *)
    var horizontalScrollIndicatorInsets: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: underlyingObject, \.horizontalScrollIndicatorInsets)
    }
    
    var scrollIndicatorInsets: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: underlyingObject, \.scrollIndicatorInsets)
    }
    
    var delaysContentTouches: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.delaysContentTouches)
    }
    
    var canCancelContentTouches: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.canCancelContentTouches)
    }
    
    var minimumZoomScale: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.minimumZoomScale)
    }
    
    var maximumZoomScale: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.maximumZoomScale)
    }
    
    var zoomScale: AssociativeTwoWayRelay<CGFloat> {
        .relay(of: underlyingObject, \.zoomScale)
    }
    
    var bouncesZoom: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.bouncesZoom)
    }
    
    var scrollsToTop: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.scrollsToTop)
    }
    
    var refreshControl: AssociativeTwoWayRelay<UIRefreshControl?> {
        .relay(of: underlyingObject, \.refreshControl)
    }
    
}
#endif
