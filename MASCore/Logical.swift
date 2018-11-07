//
//  Logical.swift
//  MAS
//
//  Created by Gregory Higley on 7/17/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

infix operator &&!: LogicalConjunctionPrecedence
infix operator ||!: LogicalConjunctionPrecedence

/// Eager version of &&, useful in function composition
public func eagerAnd(_ lhs: Bool, _ rhs: Bool) -> Bool {
    return lhs && rhs
}

/// Eager version of &&, useful in function composition
public func &&!(lhs: Bool, rhs: Bool) -> Bool {
    return lhs && rhs
}

/// Eager version of ||, useful in function composition
public func eagerOr(_ lhs: Bool, _ rhs: Bool) -> Bool {
    return lhs || rhs
}

/// Eager version of ||, useful in function composition
public func ||!(lhs: Bool, rhs: Bool) -> Bool {
    return lhs || rhs
}

