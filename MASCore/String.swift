//
//  String.swift
//  MASCore
//
//  Created by Gregory Higley on 10/29/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

public extension String {

    func caseInsensitiveContains<S: StringProtocol>(_ other: S) -> Bool {
        return range(of: other, options: .caseInsensitive, range: nil, locale: nil) != nil
    }
    
}
