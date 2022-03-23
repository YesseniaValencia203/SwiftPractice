
import Foundation

extension URLSession {
    enum RequestErrors: Error {
        case badURL
        case badData
    }
}
