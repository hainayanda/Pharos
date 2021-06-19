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
        .relay(of: object, \.text)
    }

    var font: AssociativeTwoWayRelay<UIFont?> {
        .relay(of: object, \.font)
    }

    var textColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.textColor)
    }

    var textAlignment: AssociativeTwoWayRelay<NSTextAlignment> {
        .relay(of: object, \.textAlignment)
    }

    var selectedRange: AssociativeTwoWayRelay<NSRange> {
        .relay(of: object, \.selectedRange)
    }

    var isEditable: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isEditable)
    }

    var isSelectable: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isSelectable)
    }
    
    var allowsEditingTextAttributes: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.allowsEditingTextAttributes)
    }
    
    var attributedText: AssociativeTwoWayRelay<NSAttributedString> {
        .relay(of: object, \.attributedText)
    }
    
    var inputView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.inputView)
    }

    var inputAccessoryView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.inputAccessoryView)
    }
    
    var clearsOnInsertion: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.clearsOnInsertion)
    }
    
    var textContainerInset: AssociativeTwoWayRelay<UIEdgeInsets> {
        .relay(of: object, \.textContainerInset)
    }
    
    @available(iOS 13.0, *)
    var usesStandardTextScaling: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.usesStandardTextScaling)
    }
}

// MARK: UITextField

public extension RelayCollection where Object: UITextField {
    
    // MARK: Two Way Relay
    
    var text: AssociativeTwoWayRelay<String?> {
        .relay(of: object, \.text)
    }
    
    var attributedText: AssociativeTwoWayRelay<NSAttributedString?> {
        .relay(of: object, \.attributedText)
    }
    
    var textColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.textColor)
    }
    
    var font: AssociativeTwoWayRelay<UIFont?> {
        .relay(of: object, \.font)
    }
    
    var placeholder: AssociativeTwoWayRelay<String?> {
        .relay(of: object, \.placeholder)
    }

    var adjustsFontSizeToFitWidth: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.adjustsFontSizeToFitWidth)
    }

    var delegate: AssociativeTwoWayRelay<UITextFieldDelegate?> {
        .relay(of: object, \.delegate)
    }
    
    var disabledBackground: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: object, \.disabledBackground)
    }
    
    var allowsEditingTextAttributes: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.allowsEditingTextAttributes)
    }
    
    var leftView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.leftView)
    }
    
    var rightView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.rightView)
    }

    var rightViewMode: AssociativeTwoWayRelay<UITextField.ViewMode> {
        .relay(of: object, \.rightViewMode)
    }
    
    var inputView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.inputView)
    }

    var inputAccessoryView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.inputAccessoryView)
    }
    
    var clearsOnInsertion: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.clearsOnInsertion)
    }
    
}

// MARK: UISearchBar

public extension RelayCollection where Object: UISearchBar {
    
    // MARK: Two Way Relay

    var delegate: AssociativeTwoWayRelay<UISearchBarDelegate?> {
        .relay(of: object, \.delegate)
    }

    var text: AssociativeTwoWayRelay<String?> {
        .relay(of: object, \.text)
    }

    var prompt: AssociativeTwoWayRelay<String?> {
        .relay(of: object, \.prompt)
    }

    var placeholder: AssociativeTwoWayRelay<String?> {
        .relay(of: object, \.placeholder)
    }

    var showsBookmarkButton: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.showsBookmarkButton)
    }
    
    var showsCancelButton: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.showsCancelButton)
    }
    
    var showsSearchResultsButton: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.showsSearchResultsButton)
    }
    
    var isSearchResultsButtonSelected: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isSearchResultsButtonSelected)
    }
    
    var barTintColor: AssociativeTwoWayRelay<UIColor?> {
        .relay(of: object, \.barTintColor)
    }
    
    var isTranslucent: AssociativeTwoWayRelay<Bool> {
        .relay(of: object, \.isTranslucent)
    }
    
    var inputAccessoryView: AssociativeTwoWayRelay<UIView?> {
        .relay(of: object, \.inputAccessoryView)
    }
    
    var backgroundImage: AssociativeTwoWayRelay<UIImage?> {
        .relay(of: object, \.backgroundImage)
    }
    
    var searchFieldBackgroundPositionAdjustment: AssociativeTwoWayRelay<UIOffset> {
        .relay(of: object, \.searchFieldBackgroundPositionAdjustment)
    }
    
    var searchTextPositionAdjustment: AssociativeTwoWayRelay<UIOffset> {
        .relay(of: object, \.searchTextPositionAdjustment)
    }
    
}
#endif
