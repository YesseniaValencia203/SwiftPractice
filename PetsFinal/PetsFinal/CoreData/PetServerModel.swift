//
//  PetServerModel.swift
//  PetsFinal
//
//  Created by Consultant on 4/6/22.
//

import Foundation

struct PetServerModel: Codable {
    let id: Int
    let ownerID: Int
    let name: String
    let age: String
    let gender: String
    let species: String
    
    static let database = DatabaseHandler.shared
    
    func store() {
        guard let thisPet = PetServerModel.database.add(Pet.self) else { return }
        thisPet.id = Int16(id)
        thisPet.name = name
        thisPet.species = species.capitalized
        thisPet.gender = gender.capitalized
        thisPet.ownerID = Int16(ownerID)
        thisPet.age = age
        PetServerModel.database.save()
    }
}
