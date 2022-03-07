//
//  PokemonPageRequest.swift
//  PokemonAPI
//
//  Created by Consultant on 3/5/22.
//

import Foundation
import UIKit
struct PokemonPageRequest {
    var path: String { return "pokemon"}
    let parameters: Parameters
    private init(parameters: Parameters) {
        self.parameters = parameters
    }
}
extension PokemonPageRequest {
    static func from(site:String)
}
