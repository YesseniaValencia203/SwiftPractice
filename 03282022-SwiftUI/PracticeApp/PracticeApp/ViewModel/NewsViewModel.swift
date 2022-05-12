//
//  NewsViewModel.swift
//  PracticeApp
//
//  Created by Consultant on 3/28/22.
//

import Foundation
import Combine

protocol NewsViewModel {
    func getArticles()
}
/*
 ObservableObject is a type of object with a publisher that emits before the object has changed.
 */
class NewsViewModelImpl: NewsViewModel, ObservableObject {
    
    private let service: NewsService
    private(set) var articles = [Article]()
    
    
    @Published private(set) var state: ResultStates = .loading
    
    init(service: NewsService) {
        self.service = service
    }
    private var cancellables = Set<AnyCancellable>()
    
    func getArticles() {
        
        self.state = .loading
        
        let cancellable = service.request(from: .getNews)
            .sink { result in
                switch result {
                case .finished:
                    self.state = .success(content: self.articles)
                case .failure(let error):
                    // return error
                    self.state = .failed(error: error)
                    
                }
            } receiveValue: { response in
                self.articles = response.articles
            }

        self.cancellables.insert(cancellable)
    }
}
