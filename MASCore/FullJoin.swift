//
//  FullJoin.swift
//  MASCore
//
//  Created by Gregory Higley on 7/29/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

public typealias FullJoinResult<Elem: Comparable> = (left: Elem?, right: Elem?)

/// Performs a full outer join of two sets.
public func fulljoin<Elem: Comparable, Elems: SetAlgebra & Sequence>(_ elems1: Elems, _ elems2: Elems) -> [FullJoinResult<Elem>] where Elem == Elems.Element {
    var result: [FullJoinResult<Elem>] = []
    result.append(contentsOf: elems1.intersection(elems2).map{ ($0, $0) })
    result.append(contentsOf: elems1.subtracting(elems2).map{ ($0, nil) })
    result.append(contentsOf: elems2.subtracting(elems1).map{ (nil, $0) })
    return result
}

