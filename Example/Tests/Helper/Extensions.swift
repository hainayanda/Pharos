//
//  Extensions.swift
//  Pharos_Tests
//
//  Created by Nayanda Haberty on 04/02/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

extension String {
    static func randomString(length: Int = 8) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}
