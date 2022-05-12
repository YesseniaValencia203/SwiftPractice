//
//  NewsResponse.swift
//  PracticeApp
//
//  Created by Consultant on 3/28/22.
//

import Foundation

struct NewsResponse: Decodable {
    let articles: [Article]
}
/*
 In order to work with the SwiftUI  equivalent of UIKit tableviews, we will be using a list. Each element in a SwiftUI list must be unique, in order to have unique identifiers, we are using UUID
 https://www.appypie.com/random-unique-identifier
 */
struct Article: Decodable, Identifiable {
    var id = UUID()
    let author: String?
    let url: String?
    let source, title, articleDescription: String?
    let image: String?
    let date: Date?
    
    enum CodingKeys: String, CodingKey {
        case author, url, source, title
        /*
         description is reserved word in Swift so we cannot use it as a variable in our structure to decode the data and must therefore use codingkeys
         */
        case articleDescription = "description"
        case image, date
    }
}
extension Article {
    static var dummyData: Article {
        .init(author: "Yaroslav Trofimov and Max Colchester", url: "https://www.wsj.com/articles/roman-abramovich-and-ukrainian-peace-negotiators-suffer-symptoms-of-suspected-poisoning-11648480493", source: "The Wall Street Journal", title: "Roman Abramovich and Ukrainian Peace Negotiators Suffer Suspected Poisoning - The Wall Street Journal", articleDescription: "The Russian oligarch and at least two senior members of the Ukrainian team developed symptoms that they blamed on hard-liners in Moscow who they said wanted to sabotage talks to end the war.", image:  "https://images.wsj.net/im-513381/social", date: Date())
    }
}
