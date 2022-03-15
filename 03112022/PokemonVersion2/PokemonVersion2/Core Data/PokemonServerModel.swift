//
//  PokemonServerModel.swift
//  PokemonVersion2
//
//  Created by Consultant on 3/11/22.
//

import Foundation

struct PokemonPageModel: Codable {
    
}
struct PokemonServerModel: Codable {
    let name: String?
    let url: URL?
    static let database = DatabaseHandler.shared
    func store() {
        guard let pokemon = PokemonServerModel.database.add(PokemonEntity.self) else {return}
        let pokemonList = PokemonServerModel.database.fetch(PokemonEntity.self)
        
        pokemon.name = (name!).capitalized
        pokemon.url = (url!).absoluteString
        PokemonServerModel.database.save()
        print("\(name) Successfully Added")
        
    }
    
}
