//
//  CaseSensitiveUUID.swift
//  MAS
//
//  Created by Gregory Higley on 7/15/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

/**
 The MAS Engine unfortunately uses case-sensitive UUIDs.
 
 - warning: While this type supports initialization with a String
 literal, passing a value which is not supported by Apple's `UUID`
 type will cause an unrecoverable runtime exception. Use with care.
 */
public struct CaseSensitiveUUID: Hashable, Codable, CustomStringConvertible, ExpressibleByStringLiteral {
    public let description: String
    
    public init?(uuidString: String) {
        if UUID(uuidString: uuidString) == nil {
            return nil
        }
        self.description = uuidString
    }
    
    public init(stringLiteral value: String) {
        self.init(uuidString: value)!
    }
    
    public init(lowercasedUUID uuid: UUID) {
        description = uuid.uuidString.lowercased()
    }
    
    public init() {
        self.init(lowercasedUUID: UUID())
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        _ = try container.decode(UUID.self)
        description = try container.decode(String.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
    
    public static func ==(lhs: CaseSensitiveUUID, rhs: CaseSensitiveUUID) -> Bool {
        return lhs.description == rhs.description
    }
}
