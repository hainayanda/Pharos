//
//  ChangeClassWrapper.swift
//  Pharos_Tests
//
//  Created by Nayanda Haberty on 04/02/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Pharos

class ChangesClassWrapper<State> {
    var setCount: Int = 0
    var changes: Changes<State>? {
        didSet {
            setCount += 1
        }
    }
}
