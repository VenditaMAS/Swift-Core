//
//  ThrowIfNil.swift
//  MASCore
//
//  Created by Gregory Higley on 7/29/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

infix operator ??!: NilCoalescingPrecedence

/**
 If the first argument is not nil, returns it unwrapped. Otherwise throws the second argument.
 
 This is very similar to Rust's `expect`.
 */
@discardableResult public func ??!<T>(lhs: T?, rhs: @autoclosure () -> Error) throws -> T {
    guard let lhs = lhs else {
        throw rhs()
    }
    return lhs
}
