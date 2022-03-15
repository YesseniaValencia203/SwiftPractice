//
//  ValidationService.swift
//  TestingExample
//
//  Created by Consultant on 3/15/22.
//

import Foundation

/*
 This should be its own model file.
 
 */
struct User {
    let username: String
    let password: String
}
struct FibonacciResult {
    let userInput: String
    let result: String
}
/*
 This should be in the services folder. 
 */
struct ValidationService {
    func validateUserName(_ username: String?) throws -> String {
        guard let username = username else { throw ValidationError.invalidEntry }
        guard username.count > 3 else { throw ValidationError.usernameTooShort }
        guard username.count < 10 else { throw ValidationError.usernameTooLong }
        return username
    }
    
    func validatePassword(_ password: String?) throws ->  String {
        guard let password = password else { throw ValidationError.invalidEntry }
        guard password.count > 5 else { throw ValidationError.passwordTooShort }
        guard password.count < 12 else { throw ValidationError.passwordTooLong }
        
        return password
    }
    func validateInput(_ userInput: String?) throws -> Int {
        guard let userInput = userInput else { throw ValidationError.invalidEntry}
        guard let numericalInput = Int(userInput) else { throw ValidationError.inputNotNumerical }
        guard numericalInput > 0 else { throw ValidationError.negativeNumber }
        guard numericalInput < 9 else { throw ValidationError.overTenSpaces }
        
        return numericalInput
        
    }

}
enum ValidationError: LocalizedError {
    case invalidEntry
    case usernameTooShort
    case usernameTooLong
    case passwordTooShort
    case passwordTooLong
    case inputNotNumerical
    case negativeNumber
    case overTenSpaces
}
