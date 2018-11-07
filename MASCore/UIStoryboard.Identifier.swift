//
//  UIStoryboard.Identifier.swift
//  MASCore iOS
//
//  Created by Gregory Higley on 9/24/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /// The identifier of a controller inside a UIStoryboard
    public struct Identifier: CustomStringConvertible, ExpressibleByStringLiteral, Hashable {
        public let description: String
        public init(stringLiteral value: String) {
            description = value
        }
    }
    
    /// The name of a storyboard
    public struct Name: CustomStringConvertible, ExpressibleByStringLiteral, Hashable {
        public let description: String
        public init(stringLiteral value: String) {
            description = value
        }
    }
    
}
