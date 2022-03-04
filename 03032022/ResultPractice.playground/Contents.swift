import UIKit
import Foundation
import os

/*
 Result type: implemented as enum with two cases: success and failure
 failure must conform to Error type
 */
enum NetworkError: Error {
    case badURL
}
/*
 Function accepts URL string and a completion handler, which itself will accept a Result, where the success case will store an integer with number of unread messages, and the failure case will be some sort of NetworkError
 */
func fetchUnread(from urlString: String, completionHandler: @escaping (Result<Int, NetworkError>) -> Void) {
    guard let url = URL(string: urlString) else {
        completionHandler(.failure(.badURL))
        return
    }
    print("Fetching \(url.absoluteString)...")
    completionHandler(.success(5))
}
/*
 Error we get back is now strongly typed -> must be some sort of NetworkError
 By using switch, we can exhaustive switch blocks by listing all the cases of our error enum
 
 We will get back either successful data or an error
 */
fetchUnread(from: "https://hackingwithswift.com") { result in
    switch result {
    case .success(let count):
        print("\(count) unread messages.")
    case .failure(let error):
        print(error.localizedDescription)
    }
}
/*
 Completion handler is expected to receive both an integer and error, although either may be nil
 Could return:
    Int with no error
    Int with error
    Error with no Int
    Error with Int
 
 Result wrap a successful value but can also wrap a second case that expresses the absence of a value
 Absence always conveys bonus data, because rather than just being nil, it tells us what went wrong
 */
func unreadCount2(from urlString: String, completionHandler: @escaping (Int?, NetworkError?) -> Void) {
    guard let url = URL(string: urlString) else {
        completionHandler(nil, .badURL)
        return
    }
    completionHandler(5, nil)
}
/*
 Why not throws?
 Using throws forces us to handle errors immediately, rather than store them away for later processing.
 */
func unreadCount3(from urlString: String, completionHandler: @escaping (() throws -> Int) -> Void) {
    guard let url = URL(string: urlString) else {
        completionHandler { throw NetworkError.badURL}
        return
    }
    completionHandler { return 5 }
}
unreadCount3(from: "https://www.hackingwithswift.com") { resultFunction in
    do {
        let count = try resultFunction()
        print("\(count) unread messages.")
    } catch {
        print(error.localizedDescription)
    }
}
/*
 Result has get() method that either returns a successful value if it exists, or throws error otherwise -> allows you to convert Result into a regular throwing call
 */
fetchUnread(from: "https") { result in
    if let count = try? result.get() {
        print("\(count) unread messages")
    }
}

fetchUnread(from: "https:") { result in
    if case .success(let count) = result {
        print("\(count) unread messages")
    }
}
/*
 Result has an initializer that accepts a throwing closure: if the closure returns a value successfully that gets used for the success case, otherwise the thrown error is places into the failure case
 
 */
let result = Result { try String(contentsOfFile: someFile)}
/*
 Result has four methods:
 map(): looks inside the Result and transforms the success value into a different kind of value using a closure you specify. However, if it finds failure instead, it uses that directly and ignores your transformation
 */
enum FactorError: Error {
    case belowMinimum
    case isPrime
}
func generateRandomNumber(maximum: Int) -> Result<Int, FactorError> {
    if maximum < 0 {
        return .failure(.belowMinimum)
    } else {
        let number = Int.random(in: 0...maximum)
        return .success(number)
    }
}
let result1 = generateRandomNumber(maximum: 11)
let stringNumber = result1.map {" The random Number is: \($0)."}
// map will take that random number, us it with string interpolation, and return another Result type, this time of the type Result<String, FactorError>
// if num was negative, result would be set to the failure case, and map would return Result<String, FactorError>
func calculateFactors(for num: Int) -> Result<Int, FactorError> {
    let factors = (1...num).filter { num % $0 == 0 }
    if factors.count == 2 {
        return .failure(.isPrime)
    } else {
        return .success(factors.count)
    }
}
let result2 = generateRandomNumber(maximum: 10)
//let mapResult = result2.map { calculateFactors(for: $0) } // Result<Result<Int, FactorError>, FactorError>
//let flatMapResult = result2.flatMap { calculateFactors(for: $0) } // Result<Int, FactorError>

/*
 flatMap() will return a new Result directly rather than wrapping it into another Result
 */

enum Result<Success, Failure> where Failure : Error {
    // A success case which takes the generic Success type, which can be any type, including Void
    case success(Success)
    // A failure case would take a generic Failure type which has to conform to the Error protocol
    case failure(Failure)
}
enum EvenNumberError: Error {
    case emptyArray
}
func evenNumbers(in collection: [Int]) -> Result<[Int], EvenNumberError> {
    guard !collection.isEmpty else {
        return .failure(EvenNumberError.emptyArray)
    }
    let evenNumbers = collection.filter { number in number % 2 == 0 }
    return .success(evenNumbers)
}
let numbers: [Int] = [2,3,6,8,10]
let emptyArray = [Int]()
// Passing in an empty array will give back a failure result while a collection of numbers is returned with even numbers only.

print(evenNumbers(in: emptyArray)) // Prints: failure(EvenNumberError.emptyArray)
print(evenNumbers(in: numbers)) // Prints: success([2, 6, 8, 10])


switch evenNumbers(in: numbers) {
case .success(let evenNumbers):
    print("Even numbers found: \(evenNumbers)")
case .failure(let error):
    print("Fetching even numbers failed with \(error)")
}
/*
 Benefirs of using a result return type:
    Define context by telling implementors of your methods that it can fail
    The failure error type identifies the potential errors that can occur
    Instead of returning an optional Error and result value, we can now simply switch two cases and get an unwrapped value
 */

func oldEven(in collection: [Int]) -> (EvenNumberError?, [Int]?) {
    guard !collection.isEmpty else {
        return (EvenNumberError.emptyArray, nil)
    }
    let evenNumbers = collection.filter { num in num % 2 == 0 }
    return (nil, evenNumbers)
}
let evenResult = oldEven(in: numbers)
if let error = evenResult.0 {
    print(error)
} else if let result = evenResult.1 {
    print(result)
}


enum CommonErrorType: Error {
    case otherError(error: Error)
}
let result = evenNumbers(in: numbers).mapError { (evenNumberError) -> CommonErrorType in
    return CommonErrorType.otherError(error: evenNumberError)
}
/*
 Swift lib defines methods on Result enum to transform the result value, including transforming error and value type
 Useful for when you want to match multiple different error types into one
 Or when you want to map the result value and return strings instead:
 */
let evenNumberStringResult = evenNumbers(in: numbers).map { (numbers) -> [String] in
    return numbers.map { String($0) }
}
/*
 Sometimes, you want to map the result value using a method that can fail on its own/
 */
let firstNumResult = evenNumbers(in: numbers).flatMap { (evenNumbers) -> Result<Int, EvenNumberError> in
    guard let firstEven = evenNumbers.first else {
        return .failure(EvenNumberError.emptyArray)
    }
    return .success(firstEven)
}
