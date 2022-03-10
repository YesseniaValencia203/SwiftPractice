//
//  ViewControllerTests.swift
//  DotaCodableTests
//
//  Created by Admin on 3/1/22.
//

import XCTest
@testable import DotaCodable

class ViewControllerTests: XCTestCase {
/*
 The Essential Guide to Unit Testing in iOS
 https://matteomanferdini.com/ios-unit-testing/
 TDD
 https://www.browserstack.com/guide/what-is-test-driven-development
 https://blog.devgenius.io/intro-to-test-driven-development-tdd-using-swift-and-xcode-12-f81f048923eb
 Unit & UI Testing
 https://www.raywenderlich.com/21020457-ios-unit-testing-and-ui-testing-tutorial
 */
    func testCanDecode() throws {
        let json = """
            {
        "localized_name":"Anti-Mage",
        "primary_attr":"agi",
        "attack_type":"Melee",
        "legs":2,
        "img":"/apps/dota2/images/dota_react/heroes/antimage.png?"
            }
        """
        let jsonData = json.data(using: .utf8)!
       let heroes = try JSONDecoder().decode(Hero.self, from: jsonData)
        
        XCTAssertNotNil(heroes)
        XCTAssertEqual(heroes.attackType, "Melee")
        XCTAssertEqual(heroes.legs, 2)
        
    }

}
