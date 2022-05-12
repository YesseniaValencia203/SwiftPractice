//
//  ErrorConstants.swift
//  PracticeApp
//
//  Created by Consultant on 3/28/22.
//

import Foundation

struct ErrorConstants {
    // static because they're not going to change at any point and can be accessed using dot notation 
    static let decodingError = "Failure to decode the object from the service"
    static let errorCode = "- Something went wrong"
    static let unknown = "The error is unknown"
}
