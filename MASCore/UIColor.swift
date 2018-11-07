//
//  UIColor.swift
//  MASCore
//
//  Created by Gregory Higley on 7/22/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import CoreGraphics
import UIKit

public extension UIColor {

    /// Safely creates a number from a hex color
    convenience init?(hex: UInt64, digits: Int) {
        if ![3, 4, 6, 8].contains(digits) {
            return nil
        }
        self.init(hex: String(hex, radix: 16, uppercase: false), digits: digits)
    }
    
    /// Safely creates a number from a hex string, which may contain an initial hash sign.
    convenience init?(hex: String, digits: Int? = nil) {
        var hex = String(hex.drop(while: { $0 == "#" }))
        let digits = digits ?? hex.count
        if hex.count > digits {
            return nil
        }
        if ![3, 4, 6, 8].contains(digits) {
            return nil
        }
        hex = String(repeating: "0", count: digits - hex.count) + hex
        let hexes: [String]
        if hex.count == 6 || hex.count == 8 {
            hexes = stride(from: 0, to: hex.count, by: 2).map {
                let startIndex = hex.index(hex.startIndex, offsetBy: $0)
                let endIndex = hex.index(startIndex, offsetBy: 2)
                return String(hex[startIndex..<endIndex])
            }
        } else if hex.count == 3 || hex.count == 4 {
            hexes = (0..<hex.count).map {
                let startIndex = hex.index(hex.startIndex, offsetBy: $0)
                let endIndex = hex.index(after: startIndex)
                let s = String(hex[startIndex..<endIndex])
                return s + s
            }
        } else {
            return nil
        }
        guard let red = UInt8(hexes[0], radix: 16) else {
            return nil
        }
        guard let green = UInt8(hexes[1], radix: 16) else {
            return nil
        }
        guard let blue = UInt8(hexes[2], radix: 16) else {
            return nil
        }
        let alpha = UInt8(hexes[safe: 3] ?? "ff", radix: 16) ?? 0xff
        self.init(red: CGFloat(red) / 0xff, green: CGFloat(green) / 0xff, blue: CGFloat(blue) / 0xff, alpha: CGFloat(alpha) / 0xff)
    }
    
    var hex: String {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "%02X%02X%02X%02X", UInt(r * 0xff), UInt(g * 0xff), UInt(b * 0xff), UInt(a * 0xff))
    }
}
