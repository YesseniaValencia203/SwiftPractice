//
//  Page.swift
//  MovieProject
//
//  Created by Consultant on 3/3/22.
//

import Foundation
struct Page : Codable {
    let page: Int?
    let results: [Movie]?
    let total_results : Int?
    let total_pages: Int?
}
