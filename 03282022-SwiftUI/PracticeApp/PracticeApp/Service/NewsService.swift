//
//  NewsService.swift
//  PracticeApp
//
//  Created by Consultant on 3/28/22.
//

import Foundation
import Combine
/*
 MARK: Dependency Injection:
 Dependency Injection is a software design pattern in which an object receives other instances that it depends on. It's a commonly used technique that allows reusing code, insert mocked data, and simplify testing.
 https://www.appypie.com/dependency-injection-swift
 https://www.avanderlee.com/swoft/dependency-injection
 
 Combine publishers:
 A publisher delivers elements to one or more Subscriber instances. The subscriber's Input and Failure associated types must match the Output and Failure types declared by the publisher.
 https://heckj.github.io/swiftui-notes/#coreconcepts-publisher-subscriber
 */
protocol NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError>
}

struct NewsServiceImpl: NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError> {
        return URLSession.shared
        // Returns a publisher that unwraps a URL session data task for a given url request
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown}
           // .flatMap { data, response -> AnyPublisher<NewsResponse, APIError> } in
            .flatMap { data, response -> AnyPublisher<NewsResponse, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    return Just(data)
                        .decode(type: NewsResponse.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
        // Use eraseToAnyPublisher() to expose an instance of AnyPublisher to the downstream subscriber, rather than this publisher's actual type. This form of type exposure 
        
    }
    

}
