//
//  MASCoreNameTests.swift
//  MASCore
//
//  Created by Gregory Higley on 10/1/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import XCTest
@testable import MASCore

class MASCoreNameTests: XCTestCase {

    func testFullyQualifiedName() {
        XCTAssertNotNil(FullyQualifiedName("mas0200.os.system.linux.cmd.user_management"))
        XCTAssertNil(FullyQualifiedName("  mas0200.os.system"))
        XCTAssertNil(FullyQualifiedName("\n02.xyz.abc"))
        XCTAssertNotNil(FullyQualifiedName("Ć😚.xyz"))
        XCTAssertNil(FullyQualifiedName("Ć😚.\txyz"))
        let watusi: Name = "watusi"
        let zing: Name = "zing"
        let fqn = FullyQualifiedName(watusi, in: [zing])
        for name in fqn {
            print(name)
        }
        print(fqn)
        let fqn2: FullyQualifiedName = "this.that"
        let fqn3 = fqn + fqn2 + [Name("ok")!, "yes"]
        print(fqn3)
    }
    
}
