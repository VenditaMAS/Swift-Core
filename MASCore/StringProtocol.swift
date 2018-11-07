//
//  StringProtocol.swift
//  MASCore
//
//  Created by Gregory Higley on 10/27/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

public extension StringProtocol {
    
    var isWhitespacesAndNewlines: Bool {
        return String(self).trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
