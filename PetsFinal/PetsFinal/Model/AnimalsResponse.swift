import Foundation

struct AnimalsResponse: Codable {
    let animals: [AnimalResponse]?
    let pagination: PaginationResponse?
}
struct AnimalResponse: Codable {
    let id: Int?
    
    let url: URL?
    let type: String?
    let species: String?
  //  let breeds: BreedResponse?
    let age: String?
    let gender: String?
    let coat: String?
    let name: String?
    let description: String?
    let tags: [String]?
    let photos: [Photo]
    
}
struct PaginationResponse: Codable {
    let count_per_page: Int?
    let total_count: Int?
    let current_page: Int?
    let total_pages: Int?

}

struct BreedResponse: Codable {
    let primary: String?

}
struct ColorResponse: Codable {
    let primary: String?
    
}

struct Photo: Codable {
    let small, medium, large, full: String
}
