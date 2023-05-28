//
//  StackPuterTests.swift
//  StackPuterTests
//
//  Created by Travis Luckenbaugh on 5/10/23.
//

import XCTest
@testable import StackPuter

final class StackPuterTests: XCTestCase {
    func testEval() throws {
        XCTAssert(eval("22") == [22])
        XCTAssert(eval("1 2 3 4") == [1, 2, 3, 4])
    }
    
    func testMath() throws {
        XCTAssert(eval("1 2 +") == [3])
        XCTAssert(eval("1 2 -") == [1])
        XCTAssert(eval("5 5 *") == [25])
        XCTAssert(eval("8 2 /") == [4])
        XCTAssert(eval("-2 abs") == [2])
        XCTAssert(eval("4 sqrt") == [2])
    }
    
    func testTrig() throws {
        XCTAssert(eval("2 PI DEG * *") == [360])
        XCTAssert(eval("PI 2 / sin") == [1])
        // TODO: Fix epsilon in tests
//        XCTAssert(eval("PI 2 / cos") == [0])
//        XCTAssert(eval("PI 4 / tan") == [1])
        XCTAssert(eval("0 asin") == [0])
        XCTAssert(eval("0 acos") == eval("PI 2 /"))
    }
}
