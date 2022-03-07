//
//  PokemonPage.swift
//  PokemonAPI
//
//  Created by Consultant on 3/4/22.
//

import Foundation
struct PageResult: Codable {
    let count: Int?
    let next: URL?
    let previous: URL?
    let results: [PokemonPage]?
}
struct PokemonPage: Codable {
    let name: String?
    let url: URL?
}
struct PokemonProfile: Codable {
    let abilities: [Abilities]?
    let id: Int?
    let moves: [Moves]?
    let name: String?
    let sprites: Sprite?
    let pokemonTypes: [PokemonTypes]?
    enum CodingKeys: String, CodingKey {
        case pokemonTypes = "types"
        case id = "id"
        case moves = "moves"
        case sprites = "sprites"
        case abilities = "abilities"
        case name = "name"
    }
    init(abilities: [Abilities]?, id: Int?, moves: [Moves]?, name: String?, sprites: Sprite?, pokemonTypes: [PokemonTypes]?) {
        self.abilities = abilities
        self.id = id
        self.moves = moves
        self.name = name
        self.sprites = sprites
        self.pokemonTypes = pokemonTypes
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let abilities = try container.decode([Abilities].self, forKey: .abilities)
        let id = try container.decode(Int.self, forKey: .id)
        let moves = try container.decode([Moves].self, forKey: .moves)
        let name = try container.decode(String.self, forKey: .name)
        let sprites = try container.decode(Sprite.self, forKey: .sprites)
        let pokemonTypes = try container.decode([PokemonTypes].self, forKey: .pokemonTypes)
        self.init(abilities: abilities, id: id, moves: moves, name: name, sprites: sprites, pokemonTypes: pokemonTypes)
    }
}
struct Ability: Codable {
    let name: String?
    
}
struct Abilities: Codable {
    let ability: Ability?
    let isHidden: Bool?
    let slot: Int?
}

struct Sprite: Codable {
    let front_default: URL?
    let back_default: URL?
    let front_shiny: URL?
}
struct PokemonType: Codable {
    let name: String?
}

struct PokemonTypes: Codable {
    let slot: Int?
    let type: PokemonType?
}
struct Move: Codable {
    let name: String?
    
}
struct Moves: Codable {
    let move: Move?
}
