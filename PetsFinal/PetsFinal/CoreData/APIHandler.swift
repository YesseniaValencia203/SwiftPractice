import Foundation
class APIHandler {
    static let shared = APIHandler()
    
    // returning -> () is same as -> Void
    func syncUsers(completion: @escaping(()-> ())) {
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            do {
                /*
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any>
                print(jsonResponse)
            */
                let model = try JSONDecoder().decode(APIResponse<[UserServerModel]>.self, from: data!)
                // storing each user into core data after converting out User object returning from server to a user object compatible with out core data managed object
                model.data.forEach { $0.store()}
                
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
    public let page: Int
    public let totalPages: Int
    public let total: Int
    public let perPage: Int
    public let data: T
    
    enum CodingKeys:String, CodingKey {
        case page = "page"
        case totalPages = "total_pages"
        case total = "total"
        case perPage = "per_page"
        case data = "data"
    }
}
