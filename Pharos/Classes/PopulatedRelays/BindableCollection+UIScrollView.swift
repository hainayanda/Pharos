//
//  RelayCollection+Scroll.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension BindableCollection where Object: UIScrollView {
    
    // MARK: Two Way Relay
    
    var contentOffset: BindableObservable<CGPoint> {
        bindable(of:\.contentOffset)
    }
    
    var contentSize: BindableObservable<CGSize> {
        bindable(of:\.contentSize)
    }
    
    var contentInset: BindableObservable<UIEdgeInsets> {
        bindable(of:\.contentInset)
    }
    
    var delegate: BindableObservable<UIScrollViewDelegate?> {
        bindable(of:\.delegate)
    }
    
    var isDirectionalLockEnabled: BindableObservable<Bool> {
        bindable(of:\.isDirectionalLockEnabled)
    }
    
    var bounces: BindableObservable<Bool> {
        bindable(of:\.bounces)
    }
    
    var alwaysBounceVertical: BindableObservable<Bool> {
        bindable(of:\.alwaysBounceVertical)
    }
    
    var alwaysBounceHorizontal: BindableObservable<Bool> {
        bindable(of:\.alwaysBounceHorizontal)
    }
    
    var isPagingEnabled: BindableObservable<Bool> {
        bindable(of:\.isPagingEnabled)
    }
    
    var isScrollEnabled: BindableObservable<Bool> {
        bindable(of:\.isScrollEnabled)
    }
    
    var showsVerticalScrollIndicator: BindableObservable<Bool> {
        bindable(of:\.showsVerticalScrollIndicator)
    }
    
    var showsHorizontalScrollIndicator: BindableObservable<Bool> {
        bindable(of:\.showsHorizontalScrollIndicator)
    }
    
    @available(iOS 11.1, *)
    var verticalScrollIndicatorInsets: BindableObservable<UIEdgeInsets> {
        bindable(of:\.verticalScrollIndicatorInsets)
    }
    
    @available(iOS 11.1, *)
    var horizontalScrollIndicatorInsets: BindableObservable<UIEdgeInsets> {
        bindable(of:\.horizontalScrollIndicatorInsets)
    }
    
    var scrollIndicatorInsets: BindableObservable<UIEdgeInsets> {
        bindable(of:\.scrollIndicatorInsets)
    }
    
    var delaysContentTouches: BindableObservable<Bool> {
        bindable(of:\.delaysContentTouches)
    }
    
    var canCancelContentTouches: BindableObservable<Bool> {
        bindable(of:\.canCancelContentTouches)
    }
    
    var minimumZoomScale: BindableObservable<CGFloat> {
        bindable(of:\.minimumZoomScale)
    }
    
    var maximumZoomScale: BindableObservable<CGFloat> {
        bindable(of:\.maximumZoomScale)
    }
    
    var zoomScale: BindableObservable<CGFloat> {
        bindable(of:\.zoomScale)
    }
    
    var bouncesZoom: BindableObservable<Bool> {
        bindable(of:\.bouncesZoom)
    }
    
    var scrollsToTop: BindableObservable<Bool> {
        bindable(of:\.scrollsToTop)
    }
    
    var refreshControl: BindableObservable<UIRefreshControl?> {
        bindable(of:\.refreshControl)
    }
    
}
#endif
