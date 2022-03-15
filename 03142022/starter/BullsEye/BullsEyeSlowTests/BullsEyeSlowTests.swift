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

class BullsEyeSlowTests: XCTestCase {
  var sut: URLSession!
  let networkMonitor = NetworkMonitor.shared
  // way to check for network connection
    /*
     Executing a test doesn't make sense if there isn't a network connection. The test won't pass because it won't receive a status code and it won't fail because it didn't test anything.
     */
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = URLSession(configuration: .default)
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  // Asynchronous test: success fast, failure slow
  func testValidApiCallGetsHTTPStatusCode200() throws {
    // given
    let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
    let url = URL(string: urlString)!
    // 1 Returns XCTestExpectation stored in promise. description describes what you expect to happen.
    let promise = expectation(description: "Status code: 200")

    // when
    let dataTask = sut.dataTask(with: url) { _, response, error in
      // then
      if let error = error {
        XCTFail("Error: \(error.localizedDescription)")
        return
      } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
        if statusCode == 200 {
          // 2 Call this in the success condition closure of the async method's completion handler to flag that the expectation has been met.
          promise.fulfill()
        } else {
          XCTFail("Status code: \(statusCode)")
        }
      }
    }
    dataTask.resume()
    // 3 Keeps the test running until all expectations are fulfilled or the timeout interval ends, whichever happends first.
    wait(for: [promise], timeout: 5)
  }
/*
 If test fails, but it takes the full timeout interval --> because you assumed the request would always succeed and that's where you called promise.fulfill(). Since the request failed, it finished only when the timeout expired.
 You can improve this and make the test fail faster by changing the assumption. Instead of waiting for the request to succeed, wait only until the asynchronous method's completion handler is invoked. This happens as soon as the app received a response from the server, which fulfills the expectation. You test can the check whether the request succeeded.
 */
  func testApiCallCompletes() throws {

    let urlString = "http://www.randomnumberapi.com/test"
    let url = URL(string: urlString)!
    let promise = expectation(description: "Completion handler invoked")
    var statusCode: Int?
    var responseError: Error?
    /*
     The key dofference is that simply entering the completion handler fulfills the expectatin and this only takes about a second to happen. If the request fails the then assertions fail.
     */
    let dataTask = sut.dataTask(with: url) { _, response, error in
      statusCode = (response as? HTTPURLResponse)?.statusCode
      responseError = error
      promise.fulfill()
    }
    dataTask.resume()
    wait(for: [promise], timeout: 5)
    
    XCTAssertNil(responseError)
    XCTAssertEqual(statusCode, 200)
  
  }
  
}
