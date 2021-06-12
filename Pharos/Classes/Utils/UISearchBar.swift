//
//  File.swift
//  Pharos
//
//  Created by Nayanda Haberty on 15/04/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UISearchBar {
    
    var textField: UITextField {
        if #available(iOS 13, *) {
            return searchTextField
        } else {
            return self.value(forKey: "_searchField") as! UITextField
        }
    }
    
}
#endif
