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
    
    var text: AssociativeTwoWayRelay<String?> {
        .relay(of: underlyingObject, \.text)
    }

    var font: AssociativeTwoWayRelay<UIFont?> {
        .relay(of: underlyingObject, \.font)
    }

    var textColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.textColor)
    }

    var textAlignment: AssociativeTwoWayRelay<NSTextAlignment> {
        .relay(of: underlyingObject, \.textAlignment)
    }

    var selectedRange: AssociativeTwoWayRelay<NSRange> {
        .relay(of: underlyingObject, \.selectedRange)
    }

    var isEditable: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isEditable)
    }

    var isSelectable: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isSelectable)
    }
    
    var allowsEditingTextAttributes: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.allowsEditingTextAttributes)
    }
    
    var attributedText: AssociativeTwoWayRelay<NSAttributedString> {
        .relay(of: underlyingObject, \.attributedText)
    }
    
    var inputView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.inputView)
    }

    var inputAccessoryView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.inputAccessoryView)
    }
    
    var clearsOnInsertion: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.clearsOnInsertion)
    }
    
    var textContainerInset: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: underlyingObject, \.textContainerInset)
    }
    
    @available(iOS 13.0, *)
    var usesStandardTextScaling: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.usesStandardTextScaling)
    }
}

// MARK: UITextField

public extension RelayCollection where Object: UITextField {
    
    // MARK: Two Way Relay
    
    var text: AssociativeTwoWayRelay<String?> {
        .relay(of: underlyingObject, \.text)
    }
    
    var attributedText: AssociativeTwoWayRelay<NSAttributedString?> {
        .relay(of: underlyingObject, \.attributedText)
    }
    
    var textColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.textColor)
    }
    
    var font: AssociativeTwoWayRelay<UIFont?> {
        .relay(of: underlyingObject, \.font)
    }
    
    var placeholder: AssociativeTwoWayRelay<String?> {
        .relay(of: underlyingObject, \.placeholder)
    }

    var adjustsFontSizeToFitWidth: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.adjustsFontSizeToFitWidth)
    }

    var delegate: AssociativeTwoWayRelay<UITextFieldDelegate?> {
        .relay(of: underlyingObject, \.delegate)
    }
    
    var disabledBackground: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: underlyingObject, \.disabledBackground)
    }
    
    var allowsEditingTextAttributes: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.allowsEditingTextAttributes)
    }
    
    var leftView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.leftView)
    }
    
    var rightView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.rightView)
    }

    var rightViewMode: AssociativeTwoWayRelay<UITextField.ViewMode> {
        .relay(of: underlyingObject, \.rightViewMode)
    }
    
    var inputView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.inputView)
    }

    var inputAccessoryView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.inputAccessoryView)
    }
    
    var clearsOnInsertion: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.clearsOnInsertion)
    }
    
}

// MARK: UISearchBar

public extension RelayCollection where Object: UISearchBar {
    
    // MARK: Two Way Relay

    var delegate: AssociativeTwoWayRelay<UISearchBarDelegate?> {
        .relay(of: underlyingObject, \.delegate)
    }

    var text: AssociativeTwoWayRelay<String?> {
        .relay(of: underlyingObject, \.text)
    }

    var prompt: AssociativeTwoWayRelay<String?> {
        .relay(of: underlyingObject, \.prompt)
    }

    var placeholder: AssociativeTwoWayRelay<String?> {
        .relay(of: underlyingObject, \.placeholder)
    }

    var showsBookmarkButton: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.showsBookmarkButton)
    }
    
    var showsCancelButton: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.showsCancelButton)
    }
    
    var showsSearchResultsButton: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.showsSearchResultsButton)
    }
    
    var isSearchResultsButtonSelected: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isSearchResultsButtonSelected)
    }
    
    var barTintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: underlyingObject, \.barTintColor)
    }
    
    var isTranslucent: AssociativeTwoWayRelay<Bool> {
        .relay(of: underlyingObject, \.isTranslucent)
    }
    
    var inputAccessoryView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: underlyingObject, \.inputAccessoryView)
    }
    
    var backgroundImage: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: underlyingObject, \.backgroundImage)
    }
    
    var searchFieldBackgroundPositionAdjustment: AssociativeTwoWayRelay<UIOffset> {
        .relay(of: underlyingObject, \.searchFieldBackgroundPositionAdjustment)
    }
    
    var searchTextPositionAdjustment: AssociativeTwoWayRelay<UIOffset> {
        .relay(of: underlyingObject, \.searchTextPositionAdjustment)
    }
    
}
#endif
