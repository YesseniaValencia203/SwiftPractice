
import Foundation

extension URLSession {
    /*
     Here we are extending URLSession by adding a generic networking call function that does not need concern itself about classes. The only thing we care aboue is that we are able to use the Codable protocol with whatever type we pass into the params in the function. We could alternatively make this of type T:Any meaning we could then even do JSONSerialization for example.
     */
    func getRequest<T:Codable>(url: URL?, decoding: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = url else {
            completion(.failure(RequestErrors.badURL))
            return
        }
        
        let task = self.dataTask(with: url) { data, _, error in
            guard data != nil else {
                completion(.failure(RequestErrors.badData))
                return
            }
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(decoding, from: data!)
                completion(.success(jsonResult))
                
            } catch {
                completion(.failure(error))
                
            }
        }
        task.resume()
    }
}
