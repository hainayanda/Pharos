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

public extension RelayCollection where Object: UITextView {
    
    // MARK: Two Way Relay
    
    var text: BindableRelay<String?> {
        bindable(of:\.text)
    }

    var font: BindableRelay<UIFont?> {
        bindable(of:\.font)
    }

    var textColor: BindableRelay<UIColor?> {
        bindable(of:\.textColor)
    }

    var textAlignment: BindableRelay<NSTextAlignment> {
        bindable(of:\.textAlignment)
    }

    var selectedRange: BindableRelay<NSRange> {
        bindable(of:\.selectedRange)
    }

    var isEditable: BindableRelay<Bool> {
        bindable(of:\.isEditable)
    }

    var isSelectable: BindableRelay<Bool> {
        bindable(of:\.isSelectable)
    }
    
    var allowsEditingTextAttributes: BindableRelay<Bool> {
        bindable(of:\.allowsEditingTextAttributes)
    }
    
    var attributedText: BindableRelay<NSAttributedString> {
        bindable(of:\.attributedText)
    }
    
    var inputView: BindableRelay<UIView?> {
        bindable(of:\.inputView)
    }

    var inputAccessoryView: BindableRelay<UIView?> {
        bindable(of:\.inputAccessoryView)
    }
    
    var clearsOnInsertion: BindableRelay<Bool> {
        bindable(of:\.clearsOnInsertion)
    }
    
    var textContainerInset: BindableRelay<UIEdgeInsets> {
        bindable(of:\.textContainerInset)
    }
    
    @available(iOS 13.0, *)
    var usesStandardTextScaling: BindableRelay<Bool> {
        bindable(of:\.usesStandardTextScaling)
    }
}

// MARK: UITextField

public extension RelayCollection where Object: UITextField {
    
    // MARK: Two Way Relay
    
    var text: BindableRelay<String?> {
        bindable(of:\.text)
    }
    
    var attributedText: BindableRelay<NSAttributedString?> {
        bindable(of:\.attributedText)
    }
    
    var textColor: BindableRelay<UIColor?> {
        bindable(of:\.textColor)
    }
    
    var font: BindableRelay<UIFont?> {
        bindable(of:\.font)
    }
    
    var placeholder: BindableRelay<String?> {
        bindable(of:\.placeholder)
    }

    var adjustsFontSizeToFitWidth: BindableRelay<Bool> {
        bindable(of:\.adjustsFontSizeToFitWidth)
    }

    var delegate: BindableRelay<UITextFieldDelegate?> {
        bindable(of:\.delegate)
    }
    
    var disabledBackground: BindableRelay<UIImage?> {
        bindable(of:\.disabledBackground)
    }
    
    var allowsEditingTextAttributes: BindableRelay<Bool> {
        bindable(of:\.allowsEditingTextAttributes)
    }
    
    var leftView: BindableRelay<UIView?> {
        bindable(of:\.leftView)
    }
    
    var rightView: BindableRelay<UIView?> {
        bindable(of:\.rightView)
    }

    var rightViewMode: BindableRelay<UITextField.ViewMode> {
        bindable(of:\.rightViewMode)
    }
    
    var inputView: BindableRelay<UIView?> {
        bindable(of:\.inputView)
    }

    var inputAccessoryView: BindableRelay<UIView?> {
        bindable(of:\.inputAccessoryView)
    }
    
    var clearsOnInsertion: BindableRelay<Bool> {
        bindable(of:\.clearsOnInsertion)
    }
    
}

// MARK: UISearchBar

public extension RelayCollection where Object: UISearchBar {
    
    // MARK: Two Way Relay

    var delegate: BindableRelay<UISearchBarDelegate?> {
        bindable(of:\.delegate)
    }

    var text: BindableRelay<String?> {
        bindable(of:\.text)
    }

    var prompt: BindableRelay<String?> {
        bindable(of:\.prompt)
    }

    var placeholder: BindableRelay<String?> {
        bindable(of:\.placeholder)
    }

    var showsBookmarkButton: BindableRelay<Bool> {
        bindable(of:\.showsBookmarkButton)
    }
    
    var showsCancelButton: BindableRelay<Bool> {
        bindable(of:\.showsCancelButton)
    }
    
    var showsSearchResultsButton: BindableRelay<Bool> {
        bindable(of:\.showsSearchResultsButton)
    }
    
    var isSearchResultsButtonSelected: BindableRelay<Bool> {
        bindable(of:\.isSearchResultsButtonSelected)
    }
    
    var barTintColor: BindableRelay<UIColor?> {
        bindable(of:\.barTintColor)
    }
    
    var isTranslucent: BindableRelay<Bool> {
        bindable(of:\.isTranslucent)
    }
    
    var inputAccessoryView: BindableRelay<UIView?> {
        bindable(of:\.inputAccessoryView)
    }
    
    var backgroundImage: BindableRelay<UIImage?> {
        bindable(of:\.backgroundImage)
    }
    
    var searchFieldBackgroundPositionAdjustment: BindableRelay<UIOffset> {
        bindable(of:\.searchFieldBackgroundPositionAdjustment)
    }
    
    var searchTextPositionAdjustment: BindableRelay<UIOffset> {
        bindable(of:\.searchTextPositionAdjustment)
    }
    
}
#endif
