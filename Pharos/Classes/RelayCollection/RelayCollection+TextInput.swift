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

extension UITextView: PopulatedRelays {
    public typealias BaseRelayObject = UITextView
}

public extension RelayCollection where Object: UITextView {
    
    // MARK: Two Way Relay
    
    var text: TwoWayRelay<String> {
        .relay(of: object, \.text)
    }

    var font: TwoWayRelay<UIFont?> {
        .relay(of: object, \.font)
    }

    var textColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.textColor)
    }

    var textAlignment: TwoWayRelay<NSTextAlignment> {
        .relay(of: object, \.textAlignment)
    } // default is NSLeftTextAlignment

    var selectedRange: TwoWayRelay<NSRange> {
        .relay(of: object, \.selectedRange)
    }

    var isEditable: TwoWayRelay<Bool> {
        .relay(of: object, \.isEditable)
    }

    var isSelectable: TwoWayRelay<Bool> {
        .relay(of: object, \.isSelectable)
    }
    
    var dataDetectorTypes: TwoWayRelay<UIDataDetectorTypes> {
        .relay(of: object, \.dataDetectorTypes)
    }
    
    var allowsEditingTextAttributes: TwoWayRelay<Bool> {
        .relay(of: object, \.allowsEditingTextAttributes)
    }
    
    var attributedText: TwoWayRelay<NSAttributedString> {
        .relay(of: object, \.attributedText)
    }

    var typingAttributes: TwoWayRelay<[NSAttributedString.Key: Any]> {
        .relay(of: object, \.typingAttributes)
    }
    
    var inputView: TwoWayRelay<UIView?> {
        .relay(of: object, \.inputView)
    }

    var inputAccessoryView: TwoWayRelay<UIView?> {
        .relay(of: object, \.inputAccessoryView)
    }
    
    var clearsOnInsertion: TwoWayRelay<Bool> {
        .relay(of: object, \.clearsOnInsertion)
    }
    
    var textContainerInset: TwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.textContainerInset)
    }
    
    @available(iOS 13.0, *)
    var usesStandardTextScaling: TwoWayRelay<Bool> {
        .relay(of: object, \.usesStandardTextScaling)
    }
    
    // MARK: Value Relay
    
    var textContainer: ValueRelay<NSTextContainer> {
        .relay(of: object, \.textContainer)
    }
    
    var layoutManager: ValueRelay<NSLayoutManager> {
        .relay(of: object, \.layoutManager)
    }
    
    var textStorage: ValueRelay<NSTextStorage> {
        .relay(of: object, \.textStorage)
    }
    
    var linkTextAttributes: ValueRelay<[NSAttributedString.Key: Any]> {
        .relay(of: object, \.linkTextAttributes)
    }
}

// MARK: UITextField

extension UITextField: PopulatedRelays {
    public typealias BaseRelayObject = UITextField
}

public extension RelayCollection where Object: UITextField {
    
    // MARK: Two Way Relay
    
    var text: TwoWayRelay<String?> {
        .relay(of: object, \.text)
    }
    
    var attributedText: TwoWayRelay<NSAttributedString?> {
        .relay(of: object, \.attributedText)
    }
    
    var textColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.textColor)
    }
    
    var font: TwoWayRelay<UIFont?> {
        .relay(of: object, \.font)
    }
    
    var textAlignment: TwoWayRelay<NSTextAlignment> {
        .relay(of: object, \.textAlignment)
    }
    
    var borderStyle: TwoWayRelay<UITextField.BorderStyle> {
        .relay(of: object, \.borderStyle)
    }
    
    var defaultTextAttributes: TwoWayRelay<[NSAttributedString.Key: Any]> {
        .relay(of: object, \.defaultTextAttributes)
    }
    
    var placeholder: TwoWayRelay<String?> {
        .relay(of: object, \.placeholder)
    }
    
    var attributedPlaceholder: TwoWayRelay<NSAttributedString?> {
        .relay(of: object, \.attributedPlaceholder)
    }

    var clearsOnBeginEditing: TwoWayRelay<Bool> {
        .relay(of: object, \.clearsOnBeginEditing)
    }

    var adjustsFontSizeToFitWidth: TwoWayRelay<Bool> {
        .relay(of: object, \.adjustsFontSizeToFitWidth)
    }

    var minimumFontSize: TwoWayRelay<CGFloat> {
        .relay(of: object, \.minimumFontSize)
    }

    var delegate: TwoWayRelay<UITextFieldDelegate?> {
        .relay(of: object, \.delegate)
    }
    
    var background: TwoWayRelay<UIImage?> {
        .relay(of: object, \.background)
    }
    
    var disabledBackground: TwoWayRelay<UIImage?> {
        .relay(of: object, \.disabledBackground)
    }
    
    var allowsEditingTextAttributes: TwoWayRelay<Bool> {
        .relay(of: object, \.allowsEditingTextAttributes)
    }
    
    var typingAttributes: TwoWayRelay<[NSAttributedString.Key: Any]?> {
        .relay(of: object, \.typingAttributes)
    }
    
    var clearButtonMode: TwoWayRelay<UITextField.ViewMode> {
        .relay(of: object, \.clearButtonMode)
    }
    
    var leftView: TwoWayRelay<UIView?> {
        .relay(of: object, \.leftView)
    }
    
    var leftViewMode: TwoWayRelay<UITextField.ViewMode> {
        .relay(of: object, \.leftViewMode)
    }
    
    var rightView: TwoWayRelay<UIView?> {
        .relay(of: object, \.rightView)
    }

    var rightViewMode: TwoWayRelay<UITextField.ViewMode> {
        .relay(of: object, \.rightViewMode)
    }
    
    var inputView: TwoWayRelay<UIView?> {
        .relay(of: object, \.inputView)
    }

    var inputAccessoryView: TwoWayRelay<UIView?> {
        .relay(of: object, \.inputAccessoryView)
    }
    
    var clearsOnInsertion: TwoWayRelay<Bool> {
        .relay(of: object, \.clearsOnInsertion)
    }
    
    // MARK: Value Relay
    
    var isEditing: ValueRelay<Bool> {
        .relay(of: object, \.isEditing)
    }
    
}

// MARK: UISearchBar

extension UISearchBar: PopulatedRelays {
    public typealias BaseRelayObject = UISearchBar
}

public extension RelayCollection where Object: UISearchBar {
    
    // MARK: Two Way Relay
    
    var barStyle: TwoWayRelay<UIBarStyle> {
        .relay(of: object, \.barStyle)
    }

    var delegate: TwoWayRelay<UISearchBarDelegate?> {
        .relay(of: object, \.delegate)
    }

    var text: TwoWayRelay<String?> {
        .relay(of: object, \.text)
    }

    var prompt: TwoWayRelay<String?> {
        .relay(of: object, \.prompt)
    }

    var placeholder: TwoWayRelay<String?> {
        .relay(of: object, \.placeholder)
    }

    var showsBookmarkButton: TwoWayRelay<Bool> {
        .relay(of: object, \.showsBookmarkButton)
    }
    
    var showsCancelButton: TwoWayRelay<Bool> {
        .relay(of: object, \.showsCancelButton)
    }
    
    var showsSearchResultsButton: TwoWayRelay<Bool> {
        .relay(of: object, \.showsSearchResultsButton)
    }
    
    var isSearchResultsButtonSelected: TwoWayRelay<Bool> {
        .relay(of: object, \.isSearchResultsButtonSelected)
    }
    
    var barTintColor: TwoWayRelay<UIColor?> {
        .relay(of: object, \.barTintColor)
    }
    
    var searchBarStyle: TwoWayRelay<UISearchBar.Style> {
        .relay(of: object, \.searchBarStyle)
    }
    
    var isTranslucent: TwoWayRelay<Bool> {
        .relay(of: object, \.isTranslucent)
    }
    
    var scopeButtonTitles: TwoWayRelay<[String]?> {
        .relay(of: object, \.scopeButtonTitles)
    }
    
    var selectedScopeButtonIndex: TwoWayRelay<Int> {
        .relay(of: object, \.selectedScopeButtonIndex)
    }
    
    var showsScopeBar: TwoWayRelay<Bool> {
        .relay(of: object, \.showsScopeBar)
    }
    
    var inputAccessoryView: TwoWayRelay<UIView?> {
        .relay(of: object, \.inputAccessoryView)
    }
    
    var backgroundImage: TwoWayRelay<UIImage?> {
        .relay(of: object, \.backgroundImage)
    }
    
    var scopeBarBackgroundImage: TwoWayRelay<UIImage?> {
        .relay(of: object, \.scopeBarBackgroundImage)
    }
    
    var searchFieldBackgroundPositionAdjustment: TwoWayRelay<UIOffset> {
        .relay(of: object, \.searchFieldBackgroundPositionAdjustment)
    }
    
    var searchTextPositionAdjustment: TwoWayRelay<UIOffset> {
        .relay(of: object, \.searchTextPositionAdjustment)
    }
    
    // MARK: Value Relay
    
    @available(iOS 13.0, *)
    var searchTextField: ValueRelay<UISearchTextField> {
        .relay(of: object, \.searchTextField)
    }
    
    var inputAssistantItem: ValueRelay<UITextInputAssistantItem> {
        .relay(of: object, \.inputAssistantItem)
    }
    
}
#endif
