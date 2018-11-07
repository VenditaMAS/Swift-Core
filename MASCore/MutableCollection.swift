//
//  MutableCollection.swift
//  MASCore
//
//  Created by Gregory Higley on 7/23/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

public extension MutableCollection where Self: RandomAccessCollection {
    
    mutating func sort<Attribute: Comparable>(by keyPath: KeyPath<Element, Attribute>) {
        sort{ a, b in a[keyPath: keyPath] < b[keyPath: keyPath] }
    }
    
    mutating func caseInsensitiveSort(by keyPath: KeyPath<Element, String>) {
        sort{ a, b in a[keyPath: keyPath].caseInsensitiveCompare(b[keyPath: keyPath]) == .orderedAscending }
    }
    
}
