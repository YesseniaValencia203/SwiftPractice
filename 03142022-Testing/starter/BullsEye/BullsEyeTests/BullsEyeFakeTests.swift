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
/*
 Most apps interact with system or library objects, objects you don't control. Tests that interact with these objects can be slow and unrepeatable, violating two of the FIRST principles.
 Instead, you can fake the interactions by getting input from stubs or by updating mock objects.
 Employ fakery when your code has dependency on a system or library object. Do this by creating a fake object to play that part and injecting this fake into your code. 
 */

class BullsEyeFakeTests: XCTestCase {

  var sut: BullsEyeGame!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = BullsEyeGame()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  func testStartNewRoundUsesRandomValueFromApiRequest() {
    // given
    // 1
    /*
     Set up the fake data and response and create the fake session ibkect. Finally, inkect the fake sesion into the app as property of sut
     */
    let stubbedData = "[1]".data(using: .utf8)
    let urlString =
      "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
    let url = URL(string: urlString)!
    let stubbedResponse = HTTPURLResponse(
      url: url,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil)
    let urlSessionStub = URLSessionStub(
      data: stubbedData,
      response: stubbedResponse,
      error: nil)
    sut.urlSession = urlSessionStub
    let promise = expectation(description: "Value Received")

    // when
    sut.startNewRound {
      // then
      // 2  You still have to write this as an asynchronous test because the stub is pretending to be an async method.Check whether calling startNewRound(completion:) parses the fake data by comparing targetValue with the stubbed fake number.
      XCTAssertEqual(self.sut.targetValue, 1)
      promise.fulfill()
    }
    wait(for: [promise], timeout: 5)
  }

}
