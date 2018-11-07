//
//  AdHocCodingKey.swift
//  MAS
//
//  Created by Gregory Higley on 7/15/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

public struct AdHocCodingKey: CodingKey {
    public let stringValue: String
    public let intValue: Int?
    
    public init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    public init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
    
    public init(_ stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
}

