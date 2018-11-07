//
//  OrderedIdentifier.swift
//  MAS
//
//  Created by Gregory Higley on 6/20/18.
//  Copyright © 2018 Vendita Technology Group, Inc. All rights reserved.
//

import Foundation

public struct OrderedIdentifier: Hashable, Comparable {
    fileprivate let ticks = mach_absolute_time()
}

public func <(lhs: OrderedIdentifier, rhs: OrderedIdentifier) -> Bool {
    return lhs.ticks < rhs.ticks
}

extension OrderedIdentifier: CustomStringConvertible {
    public var description: String {
        return "\(ticks)"
    }
}

extension OrderedIdentifier: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "OrderedIdentifier(ticks: \(ticks))"
    }
}
