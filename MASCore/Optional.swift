//
//  Optional.swift
//  MASCore
//
//  Created by Gregory Higley on 10/27/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

public extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

public extension Optional where Wrapped: StringProtocol {
    var isNilOrWhitespacesAndNewlines: Bool {
        return self?.isWhitespacesAndNewlines ?? true
    }
}
