//
//  RelayCollection+TextInput.swift
//  Pharos
//
//  Created by Nayanda Haberty on 12/06/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: UITextView

public extension BindableCollection where Object: UITextView {
    
    // MARK: Two Way Relay
    
    var text: BindableObservable<String?> {
        bindable(of:\.text)
    }

    var font: BindableObservable<UIFont?> {
        bindable(of:\.font)
    }

    var textColor: BindableObservable<UIColor?> {
        bindable(of:\.textColor)
    }

    var textAlignment: BindableObservable<NSTextAlignment> {
        bindable(of:\.textAlignment)
    }

    var selectedRange: BindableObservable<NSRange> {
        bindable(of:\.selectedRange)
    }

    var isEditable: BindableObservable<Bool> {
        bindable(of:\.isEditable)
    }

    var isSelectable: BindableObservable<Bool> {
        bindable(of:\.isSelectable)
    }
    
    var allowsEditingTextAttributes: BindableObservable<Bool> {
        bindable(of:\.allowsEditingTextAttributes)
    }
    
    var attributedText: BindableObservable<NSAttributedString> {
        bindable(of:\.attributedText)
    }
    
    var inputView: BindableObservable<UIView?> {
        bindable(of:\.inputView)
    }

    var inputAccessoryView: BindableObservable<UIView?> {
        bindable(of:\.inputAccessoryView)
    }
    
    var clearsOnInsertion: BindableObservable<Bool> {
        bindable(of:\.clearsOnInsertion)
    }
    
    var textContainerInset: BindableObservable<UIEdgeInsets> {
        bindable(of:\.textContainerInset)
    }
    
    @available(iOS 13.0, *)
    var usesStandardTextScaling: BindableObservable<Bool> {
        bindable(of:\.usesStandardTextScaling)
    }
}

// MARK: UITextField

public extension BindableCollection where Object: UITextField {
    
    // MARK: Two Way Relay
    
    var text: BindableObservable<String?> {
        bindable(of:\.text)
    }
    
    var attributedText: BindableObservable<NSAttributedString?> {
        bindable(of:\.attributedText)
    }
    
    var textColor: BindableObservable<UIColor?> {
        bindable(of:\.textColor)
    }
    
    var font: BindableObservable<UIFont?> {
        bindable(of:\.font)
    }
    
    var placeholder: BindableObservable<String?> {
        bindable(of:\.placeholder)
    }

    var adjustsFontSizeToFitWidth: BindableObservable<Bool> {
        bindable(of:\.adjustsFontSizeToFitWidth)
    }

    var delegate: BindableObservable<UITextFieldDelegate?> {
        bindable(of:\.delegate)
    }
    
    var disabledBackground: BindableObservable<UIImage?> {
        bindable(of:\.disabledBackground)
    }
    
    var allowsEditingTextAttributes: BindableObservable<Bool> {
        bindable(of:\.allowsEditingTextAttributes)
    }
    
    var leftView: BindableObservable<UIView?> {
        bindable(of:\.leftView)
    }
    
    var rightView: BindableObservable<UIView?> {
        bindable(of:\.rightView)
    }

    var rightViewMode: BindableObservable<UITextField.ViewMode> {
        bindable(of:\.rightViewMode)
    }
    
    var inputView: BindableObservable<UIView?> {
        bindable(of:\.inputView)
    }

    var inputAccessoryView: BindableObservable<UIView?> {
        bindable(of:\.inputAccessoryView)
    }
    
    var clearsOnInsertion: BindableObservable<Bool> {
        bindable(of:\.clearsOnInsertion)
    }
    
}

// MARK: UISearchBar

public extension BindableCollection where Object: UISearchBar {
    
    // MARK: Two Way Relay

    var delegate: BindableObservable<UISearchBarDelegate?> {
        bindable(of:\.delegate)
    }

    var text: BindableObservable<String?> {
        bindable(of:\.text)
    }

    var prompt: BindableObservable<String?> {
        bindable(of:\.prompt)
    }

    var placeholder: BindableObservable<String?> {
        bindable(of:\.placeholder)
    }

    var showsBookmarkButton: BindableObservable<Bool> {
        bindable(of:\.showsBookmarkButton)
    }
    
    var showsCancelButton: BindableObservable<Bool> {
        bindable(of:\.showsCancelButton)
    }
    
    var showsSearchResultsButton: BindableObservable<Bool> {
        bindable(of:\.showsSearchResultsButton)
    }
    
    var isSearchResultsButtonSelected: BindableObservable<Bool> {
        bindable(of:\.isSearchResultsButtonSelected)
    }
    
    var barTintColor: BindableObservable<UIColor?> {
        bindable(of:\.barTintColor)
    }
    
    var isTranslucent: BindableObservable<Bool> {
        bindable(of:\.isTranslucent)
    }
    
    var inputAccessoryView: BindableObservable<UIView?> {
        bindable(of:\.inputAccessoryView)
    }
    
    var backgroundImage: BindableObservable<UIImage?> {
        bindable(of:\.backgroundImage)
    }
    
    var searchFieldBackgroundPositionAdjustment: BindableObservable<UIOffset> {
        bindable(of:\.searchFieldBackgroundPositionAdjustment)
    }
    
    var searchTextPositionAdjustment: BindableObservable<UIOffset> {
        bindable(of:\.searchTextPositionAdjustment)
    }
    
}
#endif
