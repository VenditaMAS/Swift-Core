//
//  UINib.Name.swift
//  MASCore iOS
//
//  Created by Gregory Higley on 10/10/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import UIKit

extension UINib {
    public struct Name: CustomStringConvertible, ExpressibleByStringLiteral, Hashable {
        public let description: String
        public init(stringLiteral value: String) {
            description = value
        }
    }
}
