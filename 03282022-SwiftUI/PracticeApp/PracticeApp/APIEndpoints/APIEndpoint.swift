//
//  APIEndpoint.swift
//  PracticeApp
//
//  Created by Consultant on 3/28/22.
//

import Foundation
/*
 In order to make our code more reusable we are going to buitld our request using a protocol, this will allow us to add other requests that can reuse this blueprint for making a GET request
 */
protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}
// we can add cases as the app grows to get reviews, update video for example

enum NewsAPI {
    case getNews
//    return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
    
}

extension NewsAPI: APIBuilder {
    var baseUrl: URL {
        switch self {
        case .getNews:
            return URL(string: "https://api.lil.software")!
        }
    }
    
    var path: String {
        return "/news"
    }
    
    var urlRequest: URLRequest {
        /*
         this appendingpathcomponent performs a file system operation to determine if the path component is a directory. If so, it will append a trailing /. If you know in advance that the path component is a directory or not, then use appendingpathcomponent
         */
        return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))

    }
}
