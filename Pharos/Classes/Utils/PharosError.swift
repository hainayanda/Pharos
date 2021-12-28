//
//  PharosError.swift
//  Pharos
//
//  Created by Nayanda Haberty on 28/12/21.
//

import Foundation

public struct PharosMapError<Real>: LocalizedError {
    public let beforeMapped: Real
    public let error: Error
}

public struct PharosBiMergeIncompleteError<V1, V2>: LocalizedError {
    public let realValue1: RelayValue<V1>
    public let realValue2: RelayValue<V2>
    
    init(_ realValue1: RelayValue<V1>, _ realValue2: RelayValue<V2>) {
        self.realValue1 = realValue1
        self.realValue2 = realValue2
    }
}

public struct PharosTriMergeIncompleteError<V1, V2, V3>: LocalizedError {
    public let realValue1: RelayValue<V1>
    public let realValue2: RelayValue<V2>
    public let realValue3: RelayValue<V3>
    
    init(_ realValue1: RelayValue<V1>, _ realValue2: RelayValue<V2>, _ realValue3: RelayValue<V3>) {
        self.realValue1 = realValue1
        self.realValue2 = realValue2
        self.realValue3 = realValue3
    }
}

public struct PharosQuadMergeIncompleteError<V1, V2, V3, V4>: LocalizedError {
    public let realValue1: RelayValue<V1>
    public let realValue2: RelayValue<V2>
    public let realValue3: RelayValue<V3>
    public let realValue4: RelayValue<V4>
    
    init(_ realValue1: RelayValue<V1>, _ realValue2: RelayValue<V2>, _ realValue3: RelayValue<V3>, _ realValue4: RelayValue<V4>) {
        self.realValue1 = realValue1
        self.realValue2 = realValue2
        self.realValue3 = realValue3
        self.realValue4 = realValue4
    }
}
