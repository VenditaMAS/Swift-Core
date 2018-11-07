//
//  MASCoreColorTests.swift
//  MASCore
//
//  Created by Gregory Higley on 7/23/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import XCTest
@testable import MASCore

class MASCoreColorTests: XCTestCase {

    func testFullHexWithAlpha() {
        guard let color = UIColor(hex: 0xffffffff, digits: 8) else {
            XCTFail()
            return
        }
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 1)
        XCTAssertEqual(green, 1)
        XCTAssertEqual(blue, 1)
        XCTAssertEqual(alpha, 1)
        XCTAssertEqual(color.hex, "FFFFFFFF")
    }
    
    func testConversionFromHexAndBack() {
        guard let color = UIColor(hex: 0x6523C5, digits: 6) else {
            XCTFail()
            return
        }
        XCTAssertEqual(color.hex, "6523C5FF")
    }
    
    func testAbbreviatedHexWithAlpha() {
        guard let color = UIColor(hex: 0x0008, digits: 4) else {
            XCTFail()
            return
        }
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0)
        XCTAssertEqual(green, 0)
        XCTAssertEqual(blue, 0)
        XCTAssertEqual(alpha, 0x88 / 0xff)
        XCTAssertEqual(color.hex, "00000088")
    }
    
    func testAbbreviatedHex() {
        guard let color = UIColor(hex: 0x000, digits: 3) else {
            XCTFail()
            return
        }
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 0)
        XCTAssertEqual(green, 0)
        XCTAssertEqual(blue, 0)
        XCTAssertEqual(alpha, 1)
        XCTAssertEqual(color.hex, "000000FF")
    }
    
}
