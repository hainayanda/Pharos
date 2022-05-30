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

fileprivate var textKey: String = "textKey"
fileprivate var fontKey: String = "fontKey"
fileprivate var textColorKey: String = "textColorKey"
fileprivate var textAlignmentKey: String = "textAlignmentKey"
fileprivate var selectedRangeKey: String = "selectedRangeKey"
fileprivate var isEditableKey: String = "isEditableKey"
fileprivate var isSelectableKey: String = "isSelectableKey"
fileprivate var allowsEditingTextAttributesKey: String = "allowsEditingTextAttributesKey"
fileprivate var attributedTextKey: String = "attributedTextKey"
fileprivate var inputViewKey: String = "inputViewKey"
fileprivate var inputAccessoryViewKey: String = "inputAccessoryViewKey"
fileprivate var clearsOnInsertionKey: String = "clearsOnInsertionKey"
fileprivate var textContainerInsetKey: String = "textContainerInsetKey"
fileprivate var usesStandardTextScalingKey: String = "usesStandardTextScalingKey"

public extension BindableCollection where Object: UITextView {
    
    // MARK: Two Way Relay
    var text: BindableObservable<String?> {
        bindable(of:\.text, key: &textKey)
    }

    var font: BindableObservable<UIFont?> {
        bindable(of:\.font, key: &fontKey)
    }

    var textColor: BindableObservable<UIColor?> {
        bindable(of:\.textColor, key: &textColorKey)
    }

    var textAlignment: BindableObservable<NSTextAlignment> {
        bindable(of:\.textAlignment, key: &textAlignmentKey)
    }

    var selectedRange: BindableObservable<NSRange> {
        bindable(of:\.selectedRange, key: &selectedRangeKey)
    }

    var isEditable: BindableObservable<Bool> {
        bindable(of:\.isEditable, key: &isEditableKey)
    }

    var isSelectable: BindableObservable<Bool> {
        bindable(of:\.isSelectable, key: &isSelectableKey)
    }
    
    var allowsEditingTextAttributes: BindableObservable<Bool> {
        bindable(of:\.allowsEditingTextAttributes, key: &allowsEditingTextAttributesKey)
    }
    
    var attributedText: BindableObservable<NSAttributedString> {
        bindable(of:\.attributedText, key: &attributedTextKey)
    }
    
    var inputView: BindableObservable<UIView?> {
        bindable(of:\.inputView, key: &inputViewKey)
    }

    var inputAccessoryView: BindableObservable<UIView?> {
        bindable(of:\.inputAccessoryView, key: &inputAccessoryViewKey)
    }
    
    var clearsOnInsertion: BindableObservable<Bool> {
        bindable(of:\.clearsOnInsertion, key: &clearsOnInsertionKey)
    }
    
    var textContainerInset: BindableObservable<UIEdgeInsets> {
        bindable(of:\.textContainerInset, key: &textContainerInsetKey)
    }
    
    @available(iOS 13.0, *)
    var usesStandardTextScaling: BindableObservable<Bool> {
        bindable(of:\.usesStandardTextScaling, key: &usesStandardTextScalingKey)
    }
}

// MARK: UITextField

fileprivate var placeholderKey: String = "placeholderKey"
fileprivate var adjustsFontSizeToFitWidthKey: String = "adjustsFontSizeToFitWidthKey"
fileprivate var delegateKey: String = "delegateKey"
fileprivate var disabledBackgroundKey: String = "disabledBackgroundKey"
fileprivate var leftViewKey: String = "leftViewKey"
fileprivate var rightViewKey: String = "rightViewKey"
fileprivate var rightViewModeKey: String = "rightViewModeKey"

public extension BindableCollection where Object: UITextField {
    
    // MARK: Two Way Relay
    
    var text: BindableObservable<String?> {
        bindable(of:\.text, key: &textKey)
    }
    
    var attributedText: BindableObservable<NSAttributedString?> {
        bindable(of:\.attributedText, key: &attributedTextKey)
    }
    
    var textColor: BindableObservable<UIColor?> {
        bindable(of:\.textColor, key: &textColorKey)
    }
    
    var font: BindableObservable<UIFont?> {
        bindable(of:\.font, key: &fontKey)
    }
    
    var placeholder: BindableObservable<String?> {
        bindable(of:\.placeholder, key: &placeholderKey)
    }

    var adjustsFontSizeToFitWidth: BindableObservable<Bool> {
        bindable(of:\.adjustsFontSizeToFitWidth, key: &adjustsFontSizeToFitWidthKey)
    }

    var delegate: BindableObservable<UITextFieldDelegate?> {
        bindable(of:\.delegate, key: &delegateKey)
    }
    
    var disabledBackground: BindableObservable<UIImage?> {
        bindable(of:\.disabledBackground, key: &disabledBackgroundKey)
    }
    
    var allowsEditingTextAttributes: BindableObservable<Bool> {
        bindable(of:\.allowsEditingTextAttributes, key: &allowsEditingTextAttributesKey)
    }
    
    var leftView: BindableObservable<UIView?> {
        bindable(of:\.leftView, key: &leftViewKey)
    }
    
    var rightView: BindableObservable<UIView?> {
        bindable(of:\.rightView, key: &rightViewKey)
    }

    var rightViewMode: BindableObservable<UITextField.ViewMode> {
        bindable(of:\.rightViewMode, key: &rightViewModeKey)
    }
    
    var inputView: BindableObservable<UIView?> {
        bindable(of:\.inputView, key: &inputViewKey)
    }

    var inputAccessoryView: BindableObservable<UIView?> {
        bindable(of:\.inputAccessoryView, key: &inputAccessoryViewKey)
    }
    
    var clearsOnInsertion: BindableObservable<Bool> {
        bindable(of:\.clearsOnInsertion, key: &clearsOnInsertionKey)
    }
    
}

// MARK: UISearchBar

fileprivate var promptKey: String = "promptKey"
fileprivate var showsBookmarkButtonKey: String = "showsBookmarkButtonKey"
fileprivate var showsCancelButtonKey: String = "showsCancelButtonKey"
fileprivate var showsSearchResultsButtonKey: String = "showsSearchResultsButtonKey"
fileprivate var isSearchResultsButtonSelectedKey: String = "isSearchResultsButtonSelectedKey"
fileprivate var barTintColorKey: String = "barTintColorKey"
fileprivate var isTranslucentKey: String = "isTranslucentKey"
fileprivate var backgroundImageKey: String = "backgroundImageKey"
fileprivate var searchFieldBackgroundPositionAdjustmentKey: String = "searchFieldBackgroundPositionAdjustmentKey"
fileprivate var searchTextPositionAdjustmentKey: String = "searchTextPositionAdjustmentKey"

public extension BindableCollection where Object: UISearchBar {
    
    // MARK: Two Way Relay

    var delegate: BindableObservable<UISearchBarDelegate?> {
        bindable(of:\.delegate, key: &delegateKey)
    }

    var text: BindableObservable<String?> {
        bindable(of:\.text, key: &textKey)
    }

    var prompt: BindableObservable<String?> {
        bindable(of:\.prompt, key: &promptKey)
    }

    var placeholder: BindableObservable<String?> {
        bindable(of:\.placeholder, key: &placeholderKey)
    }

    var showsBookmarkButton: BindableObservable<Bool> {
        bindable(of:\.showsBookmarkButton, key: &showsBookmarkButtonKey)
    }
    
    var showsCancelButton: BindableObservable<Bool> {
        bindable(of:\.showsCancelButton, key: &showsCancelButtonKey)
    }
    
    var showsSearchResultsButton: BindableObservable<Bool> {
        bindable(of:\.showsSearchResultsButton, key: &showsSearchResultsButtonKey)
    }
    
    var isSearchResultsButtonSelected: BindableObservable<Bool> {
        bindable(of:\.isSearchResultsButtonSelected, key: &isSearchResultsButtonSelectedKey)
    }
    
    var barTintColor: BindableObservable<UIColor?> {
        bindable(of:\.barTintColor, key: &barTintColorKey)
    }
    
    var isTranslucent: BindableObservable<Bool> {
        bindable(of:\.isTranslucent, key: &isTranslucentKey)
    }
    
    var inputAccessoryView: BindableObservable<UIView?> {
        bindable(of:\.inputAccessoryView, key: &inputAccessoryViewKey)
    }
    
    var backgroundImage: BindableObservable<UIImage?> {
        bindable(of:\.backgroundImage, key: &backgroundImageKey)
    }
    
    var searchFieldBackgroundPositionAdjustment: BindableObservable<UIOffset> {
        bindable(of:\.searchFieldBackgroundPositionAdjustment, key: &searchFieldBackgroundPositionAdjustmentKey)
    }
    
    var searchTextPositionAdjustment: BindableObservable<UIOffset> {
        bindable(of:\.searchTextPositionAdjustment, key: &searchTextPositionAdjustmentKey)
    }
    
}
#endif
