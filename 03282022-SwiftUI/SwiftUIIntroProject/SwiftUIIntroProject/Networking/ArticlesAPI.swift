//
//  ArticlesAPI.swift
//  SwiftUIIntroProject
//
//  Created by Consultant on 3/29/22.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseURL: URL { get }
    var path: String { get }
}

enum ArticlesAPI {
    case getArticles
}

extension ArticlesAPI: APIBuilder {
    // performs a file system operation to determine if the path component is a directory. If tes, it appends it or not.
    // If so, append trailing /
    // If you know it is a directory, use appendingPathComponent
    var urlRequest: URLRequest  {
        return URLRequest(url: self.baseURL.appendingPathComponent(self.path))
    }
    
    var baseURL: URL {
        switch self {
        case .getArticles:
            return URL(string: "https://api.spaceflightnewsapi.net/v3")!
        }
    }
    var path: String {
        return "/articles"
    }
}
