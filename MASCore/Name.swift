//
//  Name.swift
//  MASCore
//
//  Created by Gregory Higley on 9/28/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

/**
 One of the identifiers ("names") in a `FullyQualifiedName`.
 */
public struct Name: CustomStringConvertible, Hashable, ExpressibleByStringLiteral, Codable {
    public let description: String
    
    /// Initializes a `Name`. Returns `nil` if `name` is not a valid `Name`.
    public init?(_ name: String) {
        /*
         From vendita.mas.fnc_check_fully_qualified_name we have ^\\w{1,64}(\\.\\w{1,64})*$.
         We are of course only interested in the names between the dots. What follows is
         effectively the same as the above regex but a bit more efficient.
        */
        let regex = "^\\w+"
        if name.isEmpty || name.contains(".") || name.range(of: regex, options: [.regularExpression, .caseInsensitive], range: nil, locale: nil) == nil{
            return nil
        }
        description = name
    }
    
    public init(stringLiteral value: String) {
        self.init(value)!
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        guard let name = Name(string) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "The string '\(string)' is not a valid MASCore.Name."))
        }
        self = name
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}

public func +(lhs: Name, rhs: Name) -> FullyQualifiedName {
    return FullyQualifiedName(lhs, rhs)
}

