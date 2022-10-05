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

private var textKey: String = "textKey"
private var fontKey: String = "fontKey"
private var textColorKey: String = "textColorKey"
private var textAlignmentKey: String = "textAlignmentKey"
private var selectedRangeKey: String = "selectedRangeKey"
private var isEditableKey: String = "isEditableKey"
private var isSelectableKey: String = "isSelectableKey"
private var allowsEditingTextAttributesKey: String = "allowsEditingTextAttributesKey"
private var attributedTextKey: String = "attributedTextKey"
private var inputViewKey: String = "inputViewKey"
private var inputAccessoryViewKey: String = "inputAccessoryViewKey"
private var clearsOnInsertionKey: String = "clearsOnInsertionKey"
private var textContainerInsetKey: String = "textContainerInsetKey"
private var usesStandardTextScalingKey: String = "usesStandardTextScalingKey"

public extension BindableCollection where Object: UITextView {
    
    // MARK: Two Way Relay
    var text: Observable<String?> {
        bindable(of: \.text, key: &textKey)
    }

    var font: Observable<UIFont?> {
        bindable(of: \.font, key: &fontKey)
    }

    var textColor: Observable<UIColor?> {
        bindable(of: \.textColor, key: &textColorKey)
    }

    var textAlignment: Observable<NSTextAlignment> {
        bindable(of: \.textAlignment, key: &textAlignmentKey)
    }

    var selectedRange: Observable<NSRange> {
        bindable(of: \.selectedRange, key: &selectedRangeKey)
    }

    var isEditable: Observable<Bool> {
        bindable(of: \.isEditable, key: &isEditableKey)
    }

    var isSelectable: Observable<Bool> {
        bindable(of: \.isSelectable, key: &isSelectableKey)
    }
    
    var allowsEditingTextAttributes: Observable<Bool> {
        bindable(of: \.allowsEditingTextAttributes, key: &allowsEditingTextAttributesKey)
    }
    
    var attributedText: Observable<NSAttributedString> {
        bindable(of: \.attributedText, key: &attributedTextKey)
    }
    
    var inputView: Observable<UIView?> {
        bindable(of: \.inputView, key: &inputViewKey)
    }

    var inputAccessoryView: Observable<UIView?> {
        bindable(of: \.inputAccessoryView, key: &inputAccessoryViewKey)
    }
    
    var clearsOnInsertion: Observable<Bool> {
        bindable(of: \.clearsOnInsertion, key: &clearsOnInsertionKey)
    }
    
    var textContainerInset: Observable<UIEdgeInsets> {
        bindable(of: \.textContainerInset, key: &textContainerInsetKey)
    }
    
    @available(iOS 13.0, *)
    var usesStandardTextScaling: Observable<Bool> {
        bindable(of: \.usesStandardTextScaling, key: &usesStandardTextScalingKey)
    }
}

// MARK: UITextField

private var placeholderKey: String = "placeholderKey"
private var adjustsFontSizeToFitWidthKey: String = "adjustsFontSizeToFitWidthKey"
private var delegateKey: String = "delegateKey"
private var disabledBackgroundKey: String = "disabledBackgroundKey"
private var leftViewKey: String = "leftViewKey"
private var rightViewKey: String = "rightViewKey"
private var rightViewModeKey: String = "rightViewModeKey"

public extension BindableCollection where Object: UITextField {
    
    // MARK: Two Way Relay
    
    var text: Observable<String?> {
        bindable(of: \.text, key: &textKey)
    }
    
    var attributedText: Observable<NSAttributedString?> {
        bindable(of: \.attributedText, key: &attributedTextKey)
    }
    
    var textColor: Observable<UIColor?> {
        bindable(of: \.textColor, key: &textColorKey)
    }
    
    var font: Observable<UIFont?> {
        bindable(of: \.font, key: &fontKey)
    }
    
    var placeholder: Observable<String?> {
        bindable(of: \.placeholder, key: &placeholderKey)
    }

    var adjustsFontSizeToFitWidth: Observable<Bool> {
        bindable(of: \.adjustsFontSizeToFitWidth, key: &adjustsFontSizeToFitWidthKey)
    }

    var delegate: Observable<UITextFieldDelegate?> {
        bindable(of: \.delegate, key: &delegateKey)
    }
    
    var disabledBackground: Observable<UIImage?> {
        bindable(of: \.disabledBackground, key: &disabledBackgroundKey)
    }
    
    var allowsEditingTextAttributes: Observable<Bool> {
        bindable(of: \.allowsEditingTextAttributes, key: &allowsEditingTextAttributesKey)
    }
    
    var leftView: Observable<UIView?> {
        bindable(of: \.leftView, key: &leftViewKey)
    }
    
    var rightView: Observable<UIView?> {
        bindable(of: \.rightView, key: &rightViewKey)
    }

    var rightViewMode: Observable<UITextField.ViewMode> {
        bindable(of: \.rightViewMode, key: &rightViewModeKey)
    }
    
    var inputView: Observable<UIView?> {
        bindable(of: \.inputView, key: &inputViewKey)
    }

    var inputAccessoryView: Observable<UIView?> {
        bindable(of: \.inputAccessoryView, key: &inputAccessoryViewKey)
    }
    
    var clearsOnInsertion: Observable<Bool> {
        bindable(of: \.clearsOnInsertion, key: &clearsOnInsertionKey)
    }
    
}

// MARK: UISearchBar

private var promptKey: String = "promptKey"
private var showsBookmarkButtonKey: String = "showsBookmarkButtonKey"
private var showsCancelButtonKey: String = "showsCancelButtonKey"
private var showsSearchResultsButtonKey: String = "showsSearchResultsButtonKey"
private var isSearchResultsButtonSelectedKey: String = "isSearchResultsButtonSelectedKey"
private var barTintColorKey: String = "barTintColorKey"
private var isTranslucentKey: String = "isTranslucentKey"
private var backgroundImageKey: String = "backgroundImageKey"
// swiftlint:disable:next identifier_name
private var searchFieldBackgroundPositionAdjustmentKey: String = "searchFieldBackgroundPositionAdjustmentKey"
private var searchTextPositionAdjustmentKey: String = "searchTextPositionAdjustmentKey"

public extension BindableCollection where Object: UISearchBar {
    
    // MARK: Two Way Relay

    var delegate: Observable<UISearchBarDelegate?> {
        bindable(of: \.delegate, key: &delegateKey)
    }

    var text: Observable<String?> {
        bindable(of: \.text, key: &textKey)
    }

    var prompt: Observable<String?> {
        bindable(of: \.prompt, key: &promptKey)
    }

    var placeholder: Observable<String?> {
        bindable(of: \.placeholder, key: &placeholderKey)
    }

    var showsBookmarkButton: Observable<Bool> {
        bindable(of: \.showsBookmarkButton, key: &showsBookmarkButtonKey)
    }
    
    var showsCancelButton: Observable<Bool> {
        bindable(of: \.showsCancelButton, key: &showsCancelButtonKey)
    }
    
    var showsSearchResultsButton: Observable<Bool> {
        bindable(of: \.showsSearchResultsButton, key: &showsSearchResultsButtonKey)
    }
    
    var isSearchResultsButtonSelected: Observable<Bool> {
        bindable(of: \.isSearchResultsButtonSelected, key: &isSearchResultsButtonSelectedKey)
    }
    
    var barTintColor: Observable<UIColor?> {
        bindable(of: \.barTintColor, key: &barTintColorKey)
    }
    
    var isTranslucent: Observable<Bool> {
        bindable(of: \.isTranslucent, key: &isTranslucentKey)
    }
    
    var inputAccessoryView: Observable<UIView?> {
        bindable(of: \.inputAccessoryView, key: &inputAccessoryViewKey)
    }
    
    var backgroundImage: Observable<UIImage?> {
        bindable(of: \.backgroundImage, key: &backgroundImageKey)
    }
    
    var searchFieldBackgroundPositionAdjustment: Observable<UIOffset> {
        bindable(of: \.searchFieldBackgroundPositionAdjustment, key: &searchFieldBackgroundPositionAdjustmentKey)
    }
    
    var searchTextPositionAdjustment: Observable<UIOffset> {
        bindable(of: \.searchTextPositionAdjustment, key: &searchTextPositionAdjustmentKey)
    }
    
}
#endif
