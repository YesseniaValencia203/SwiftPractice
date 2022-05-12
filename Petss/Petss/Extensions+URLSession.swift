//
//  Extensions+URLSession.swift
//  Petss
//
//  Created by Consultant on 4/6/22.
//

import Foundation
extension URLSession {
    enum RequestErrors: Error {
        case badURL
        case badData
    }
}
