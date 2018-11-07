//
//  Sequence.swift
//  MAS
//
//  Created by Gregory Higley on 7/17/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

public extension Sequence {
    func map<Value>(_ keyPath: KeyPath<Element, Value>) -> [Value] {
        return map{ $0[keyPath: keyPath] }
    }
    
    func sorted<Attribute: Comparable>(by keyPath: KeyPath<Element, Attribute>) -> [Element] {
        return sorted{ a, b in a[keyPath: keyPath] < b[keyPath: keyPath] }
    }
    
    func sorted<Attribute: Comparable>(by keyPath: KeyPath<Element, Attribute?>) -> [Element] {
        return sorted { a, b in
            guard let a = a[keyPath: keyPath] else { return true }
            guard let b = b[keyPath: keyPath] else { return false }
            return a < b
        }
    }
    
    func caseInsensitiveSorted(by keyPath: KeyPath<Element, String>) -> [Element] {
        return sorted{ a, b in a[keyPath: keyPath].caseInsensitiveCompare(b[keyPath: keyPath]) == .orderedAscending }
    }
    
    func caseInsensitiveSorted(by keyPath: KeyPath<Element, String?>) -> [Element] {
        return sorted { a, b in
            let a = a[keyPath: keyPath] ?? ""
            let b = b[keyPath: keyPath] ?? ""
            return a.caseInsensitiveCompare(b) == .orderedAscending
        }
    }
    
    func ofType<T>(_: T.Type) -> [T] {
        return compactMap{ $0 as? T }
    }
}

/**
 Match if the pattern contains the value.
 
 - note: Why this is not a part of the standard library I do not know.
 */
public func ~=<S: Sequence>(pattern: S, value: S.Element) -> Bool where S.Element: Equatable {
    return pattern.contains(value)
}
