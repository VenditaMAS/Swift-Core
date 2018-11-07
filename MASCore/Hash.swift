//
//  Hash.swift
//  MASCore
//
//  Created by Gregory Higley on 7/29/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

@available(swift, deprecated: 4.2, message: "Use the new Hashable implementation instead.")
public func hash(_ hashables: AnyHashable?...) -> Int {
    // djb2 hash algorithm: http://www.cse.yorku.ca/~oz/hash.html
    // &+ operator handles Int overflow
    return hashables.compactMap{ $0 }.reduce(5381) { (result, hashable) in ((result << 5) &+ result) &+ hashable.hashValue }
}

