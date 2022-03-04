//
//  Movies.swift
//  MovieProject
//
//  Created by Consultant on 3/3/22.
//

import Foundation
struct Movies: Codable {
    let results:[Movie]?
    let total_pages: Int?
    let total_results: Int?
}
