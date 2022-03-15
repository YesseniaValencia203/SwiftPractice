//
//  FibTests.swift
//  TestingExampleTests
//
//  Created by Consultant on 3/15/22.
//

import XCTest
@testable import TestingExample

class FibTests: XCTestCase {
    
    func testFibSequence() {
        let expectedReturn = [0, 1, 1, 2, 3]
        var fibonacci = [0, 1]
        for i in 2...4 {
            fibonacci.append(i)
            fibonacci[i] = fibonacci[i-1] + fibonacci[i-2]
        }
        XCTAssertEqual(expectedReturn, fibonacci)
    }
}
