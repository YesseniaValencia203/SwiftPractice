//
//  ResultsModel.swift
//  MapAssignment
//
//  Created by Consultant on 3/23/22.
//

import Foundation


struct ResultsResponse: Codable {
    let results: [ResultResponse]?
}
struct ResultResponse: Codable {
    let name: NameResponse?
    let location: LocationResponse?
    let email: String?
    let picture: PictureResponse?
    
}

struct NameResponse: Codable {
    let first: String?
    let last: String?
    let title: String?
}
struct LocationResponse: Codable {
    let coordinates: CoordinatesResponse?
    
}
struct CoordinatesResponse: Codable {
    let latitude: String?
    let longitude: String?
}
struct PictureResponse: Codable {
    let thumbnail: URL?
}
