//
//  Brewery.swift
//  BreweryAPI
//
//  Created by Consultant on 3/1/22.
//

import Foundation

class Brewery {
    var name: String
    var type: String
    var city: String
    var state: String
    var postalCode: String
    var street: String
    var country: String
    var phone: String
    
    init(name: String, type: String, city: String, state: String, postalCode: String, street: String, country: String, phone: String) {
        self.name = name
        self.type = type
        self.city = city
        self.state = state
        self.country = country
        self.postalCode = postalCode
        self.street = street
        self.phone = phone
    }
}
