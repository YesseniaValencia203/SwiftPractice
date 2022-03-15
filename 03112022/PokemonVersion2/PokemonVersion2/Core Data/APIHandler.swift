//
//  APIHandler.swift
//  PokemonVersion2
//
//  Created by Consultant on 3/11/22.
//

//
//  APIHandler.swift
//  CoreDataExample
//
//  Created by Consultant on 3/10/22.
//

import Foundation
class APIHandler {
    static let shared = APIHandler()
    
    // returning -> () is same as -> Void
    func syncPokemon(completion: @escaping(()-> ())) {
        guard let url = URL(string: APIEndpoints.pokemonFullAPI) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            do {
                let model = try JSONDecoder().decode(APIResponse<[PokemonServerModel]>.self, from: data!)
                // storing each user into core data after converting out User object returning from server to a user object compatible with out core data managed object
                model.results?.forEach { $0.store() }
                
                completion()
            } catch {
                print(error.localizedDescription)
                completion()
            }
        })
        task.resume()
    }
}
// works with anything Codable but struct itself conforms to the Codable so we could decode it from the  server
// we will ned to pas in the User here in order to access API response at the data level
public struct APIResponse<T: Codable>: Codable {
    public let count: Int?
    public let next: URL?
    public let previous: URL?
    public let results: T?
}
