//
//  StackPuterTests.swift
//  StackPuterTests
//
//  Created by Travis Luckenbaugh on 5/10/23.
//

import XCTest
@testable import StackPuter

// TODO: Convert for numeric stack
final class StackPuterTests: XCTestCase {
    func testEval() throws {
        XCTAssert(eval("22") == ["22"])
        XCTAssert(eval("1 2 3 4") == ["1", "2", "3", "4"])
        XCTAssert(eval("1 2 +") == ["3.0"])
        XCTAssert(eval("1 2 -") == ["1.0"])
        XCTAssert(eval("5 5 *") == ["25.0"])
        XCTAssert(eval("2 8 /") == ["4.0"])
        XCTAssert(eval("-2 abs") == ["2.0"])
        XCTAssert(eval("4 sqrt") == ["2.0"])
    }
}
