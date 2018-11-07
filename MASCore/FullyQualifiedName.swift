//
//  FullyQualifiedName.swift
//  MASCore
//
//  Created by Gregory Higley on 9/28/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

/**
 A MAS `FullyQualifiedName`, such as the name of a process, namespace, alias, etc.
 
 A `FullyQualifiedName` consists of an ordered sequence of `Name` instances, which when
 written out as a string are separated by dots, e.g., `mas.silly.something.ok`. The very
 last `Name` in a `FullQualifiedName` is the `name`. The portion up to but not including
 this last `Name` is the optional `namespace`, which is itself a `FullyQualifiedName`.
 */
public struct FullyQualifiedName: CustomStringConvertible, Hashable, ExpressibleByStringLiteral, Codable, Collection, ExpressibleByArrayLiteral {
    public typealias Element = Name
    public typealias Index = Array<Name>.Index
    
    public let description: String
    private let names: [Name]
    
    /// An ordered sequence of `Name` instances from which to build this `FullyQualifiedName`.
    public init?<Names: Sequence>(_ names: Names) where Names.Element == Name {
        self.names = Array(names)
        if self.names.isEmpty { return nil }
        self.description = names.map{ "\($0)" }.joined(separator: ".")
    }

    /// An ordered sequence of `Name` instances from which to build this `FullyQualifiedName`.
    public init(_ name: Name, _ names: Name...) {
        self.init([name] + names)!
    }
    
    public init<Namespace: Sequence>(_ name: Name, in namespace: Namespace) where Namespace.Element == Name {
        self.init(Array(namespace).appending(name))!
    }
    
    /**
     Instantiates a `FullyQualifiedName` from a `String`. Returns `nil`
     if the `String` is not a valid representation.
     */
    public init?(_ fullyQualifiedName: String) {
        var names: [Name] = []
        for name in fullyQualifiedName.components(separatedBy: ".") {
            guard let name = Name(name) else { return nil }
            names.append(name)
        }
        self.init(names)
    }
    
    public init(stringLiteral value: String) {
        self.init(value)!
    }
    
    public init(arrayLiteral elements: Name...) {
        self.init(elements)!
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        guard let fullyQualifiedName = FullyQualifiedName(string) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "The string '\(string)' is not a valid FullyQualifiedName."))
        }
        self = fullyQualifiedName
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
    
    public var startIndex: Array<Name>.Index {
        return names.startIndex
    }
    
    public var endIndex: Array<Name>.Index {
        return names.endIndex
    }
    
    public func index(after i: Array<Name>.Index) -> Array<Name>.Index {
        return names.index(after: i)
    }
    
    public subscript(position: Array<Name>.Index) -> Name {
        return names[position]
    }
    
    /**
     The last `Name` in the ordered sequence of `Name` instances that
     constitute this `FullyQualifiedName`.
     */
    public var name: Name {
        return names.last!
    }
    
    /// The namespace portion of this `FullyQualifiedName`, if any.
    public var namespace: FullyQualifiedName? {
        return FullyQualifiedName(Array(names.dropLast()))
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
    
    public static func ==(lhs: FullyQualifiedName, rhs: FullyQualifiedName) -> Bool {
        return String(describing: lhs) == String(describing: rhs)
    }
}

public func +(lhs: FullyQualifiedName, rhs: FullyQualifiedName) -> FullyQualifiedName {
    return FullyQualifiedName(Array(lhs) + Array(rhs))!
}

public func +<Names: Collection>(lhs: FullyQualifiedName, rhs: Names) -> FullyQualifiedName where Names.Element == Name {
    return FullyQualifiedName(Array(lhs) + Array(rhs))!
}

public func +<Names: Collection>(lhs: Names, rhs: FullyQualifiedName) -> FullyQualifiedName where Names.Element == Name {
    return FullyQualifiedName(Array(lhs) + Array(rhs))!
}

public func +(lhs: FullyQualifiedName, rhs: Name) -> FullyQualifiedName {
    return FullyQualifiedName(rhs, in: lhs)
}

public func +(lhs: Name, rhs: FullyQualifiedName) -> FullyQualifiedName {
    return [lhs] + rhs
}

