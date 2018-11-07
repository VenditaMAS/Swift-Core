//
//  UIStoryboardSegue.Identifier.swift
//  MASCore iOS
//
//  Created by Gregory Higley on 9/24/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import UIKit

extension UIStoryboardSegue {
    
    public struct Identifier: CustomStringConvertible, ExpressibleByStringLiteral, Hashable {
        public let description: String
        public init(stringLiteral value: String) {
            description = value
        }
    }
    
}
