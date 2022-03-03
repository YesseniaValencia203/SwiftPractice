
import Foundation

struct Brewery: Codable {
    let name: String?
    let type: String?
    let street: String?
    let city: String?
    let state: String?
    let postalCode: String?
    let country: String?
    let phone: String?
    let website: URL?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "brewery_type"
        case street = "street"
        case city = "city"
        case state = "state"
        case postalCode = "postal_code"
        case country = "country"
        case phone = "phone"
        case website = "website_url"
    }
}
