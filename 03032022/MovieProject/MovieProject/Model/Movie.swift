//
//  Movie.swift
//  MovieProject
//
//  Created by Consultant on 3/3/22.
//

import Foundation
struct Movie: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let poster_path: String?
    let vote_average: Double?
    let release_date: String?
}
