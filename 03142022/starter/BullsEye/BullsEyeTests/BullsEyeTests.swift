/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import BullsEye
// gives the unit tests access to the internal types and functions in BullsEye

class BullsEyeTests: XCTestCase {
  var sut: BullsEyeGame!
  // creates a placeholder for BullsEyeGames, which is a System Under Test(SUT) or the object this test case class is concerned with testing.
    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = BullsEyeGame()
      // Creates BullsEyeGame at the class level so all the tests in this test class can access the SUT object's properties and methods
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
      sut = nil
      try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  func testScoreIsComputedWhenGuessIsHigherThanTarget() {
    /*
     Good practice to format test into given, when, and then sections.
     Given: set up any values needed
     When: Execute the code being tested
     Then: Assert the result you expect with message that prints if the test fails.
     */
    let guess = sut.targetValue + 5
    sut.check(guess: guess)
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
  }

  func testScoreIsComputedWhenGuessIsLowerThanTarget() {
    let guess = sut.targetValue - 5
    sut.check(guess: guess)
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
  }
  func testScoreIsComputedPerformance() {
    measure(
      /*
       Baselines are stored per device configuration, so you can have the same test executing on several different devies. Each can maintain a different baseline dependent upon the specific configuration's processor speed, memory, etc.
       Any time you make changes to an app that might impact the performance of the method being tested, run the performance test again to see how it compares to the baseline.
       */
      metrics: [
        XCTClockMetric(), // elapsed time
        XCTCPUMetric(), // CPU activity including CPU time, cycles, and number of instructions
        XCTStorageMetric(), // how much data the tested code writes to storage
        XCTMemoryMetric() // tracks the amount of used physical memory
        ]
    ) {
      sut.check(guess: 100)
    }
  }
}
