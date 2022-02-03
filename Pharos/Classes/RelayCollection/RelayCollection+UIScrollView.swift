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
    
    var contentOffset: BindableRelay<CGPoint> {
        bindable(of:\.contentOffset)
    }
    
    var contentSize: BindableRelay<CGSize> {
        bindable(of:\.contentSize)
    }
    
    var contentInset: BindableRelay<UIEdgeInsets> {
        bindable(of:\.contentInset)
    }
    
    var delegate: BindableRelay<UIScrollViewDelegate?> {
        bindable(of:\.delegate)
    }
    
    var isDirectionalLockEnabled: BindableRelay<Bool> {
        bindable(of:\.isDirectionalLockEnabled)
    }
    
    var bounces: BindableRelay<Bool> {
        bindable(of:\.bounces)
    }
    
    var alwaysBounceVertical: BindableRelay<Bool> {
        bindable(of:\.alwaysBounceVertical)
    }
    
    var alwaysBounceHorizontal: BindableRelay<Bool> {
        bindable(of:\.alwaysBounceHorizontal)
    }
    
    var isPagingEnabled: BindableRelay<Bool> {
        bindable(of:\.isPagingEnabled)
    }
    
    var isScrollEnabled: BindableRelay<Bool> {
        bindable(of:\.isScrollEnabled)
    }
    
    var showsVerticalScrollIndicator: BindableRelay<Bool> {
        bindable(of:\.showsVerticalScrollIndicator)
    }
    
    var showsHorizontalScrollIndicator: BindableRelay<Bool> {
        bindable(of:\.showsHorizontalScrollIndicator)
    }
    
    @available(iOS 11.1, *)
    var verticalScrollIndicatorInsets: BindableRelay<UIEdgeInsets> {
        bindable(of:\.verticalScrollIndicatorInsets)
    }
    
    @available(iOS 11.1, *)
    var horizontalScrollIndicatorInsets: BindableRelay<UIEdgeInsets> {
        bindable(of:\.horizontalScrollIndicatorInsets)
    }
    
    var scrollIndicatorInsets: BindableRelay<UIEdgeInsets> {
        bindable(of:\.scrollIndicatorInsets)
    }
    
    var delaysContentTouches: BindableRelay<Bool> {
        bindable(of:\.delaysContentTouches)
    }
    
    var canCancelContentTouches: BindableRelay<Bool> {
        bindable(of:\.canCancelContentTouches)
    }
    
    var minimumZoomScale: BindableRelay<CGFloat> {
        bindable(of:\.minimumZoomScale)
    }
    
    var maximumZoomScale: BindableRelay<CGFloat> {
        bindable(of:\.maximumZoomScale)
    }
    
    var zoomScale: BindableRelay<CGFloat> {
        bindable(of:\.zoomScale)
    }
    
    var bouncesZoom: BindableRelay<Bool> {
        bindable(of:\.bouncesZoom)
    }
    
    var scrollsToTop: BindableRelay<Bool> {
        bindable(of:\.scrollsToTop)
    }
    
    var refreshControl: BindableRelay<UIRefreshControl?> {
        bindable(of:\.refreshControl)
    }
    
}
#endif
