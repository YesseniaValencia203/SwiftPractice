//
//  Extensions+URLSession.swift
//  PokemonAPI
//
//  Created by Consultant on 3/4/22.
//

import Foundation

extension URLSession {
    enum RequestErrors: Error {
        case badURL
        case badData
    }
}
