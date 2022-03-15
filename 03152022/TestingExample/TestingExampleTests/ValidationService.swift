//
//  ValidationService.swift
//  TestingExampleTests
//
//  Created by Consultant on 3/15/22.
//

import XCTest
@testable import TestingExample



class ValidationServiceTests: XCTestCase {
    var validation: ValidationService!
    
    
    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }
    override func tearDown() {
        validation = nil

        super.tearDown()
    }
    
    func test_username_is_nil() throws {
        let expectedError = ValidationError.invalidEntry
        var error: ValidationError?
        XCTAssertThrowsError(try validation.validateUserName(nil)) {
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)

        // add closure
    }
    func isValidUsername() throws {
        XCTAssertNoThrow(try validation.validateUserName("admin"))
    }
    func isUsernameShort() throws {
        let expectedError = ValidationError.usernameTooShort
        var error: ValidationError?
        XCTAssertThrowsError(try validation.validateUserName("xf")) {
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
    }
    func isUsernameTooLong() {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        XCTAssertThrowsError(try validation.validateUserName("thisUdertssvs")) {
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
    }
    
    func isValidPassword() throws {
        let expectedError = ValidationError.invalidEntry
        var error: ValidationError?
        XCTAssertThrowsError(try validation.validatePassword(nil)) {
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
    }
    func isPasswordTooShort() throws {
        let expectedError = ValidationError.passwordTooShort
        var error: ValidationError?
        XCTAssertThrowsError(try validation.validatePassword("fds")) {
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
    }
    func isPasswordTooLong() throws {
        let expectedError = ValidationError.passwordTooLong
        var error: ValidationError?
        XCTAssertThrowsError(try validation.validatePassword("adiaivnisdvhsdoif")) {
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
    }
    func isPasswordValid() throws {
        XCTAssertNoThrow(try validation.validatePassword("password"))
    }
    func isUserInputValid() throws {
        XCTAssertNoThrow(try validation.validateInput("1"))
    }
    func isUserInputNumerical() throws {
        let expectedError = ValidationError.inputNotNumerical
        var error: ValidationError?
        XCTAssertThrowsError(try validation.validateInput("asd")) {
            thrownError in
            
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError,error)
    }
    func isUserInputOverTenSpaces() throws {
        let expectedError = ValidationError.overTenSpaces
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateInput("23")) {
            thrownError in
            error = thrownError as? ValidationError
        }
        XCTAssertEqual(expectedError, error)
    }
    
}
