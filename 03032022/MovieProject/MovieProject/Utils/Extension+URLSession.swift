
import Foundation
/*
 Here we are creating custom errors to work with our completion we asre passing into networking function also extending URLSession. This allows us to use the Result type with our errors.
 */
extension URLSession {
    enum RequestErrors: Error {
        case badURL
        case badData
        
    }
}

