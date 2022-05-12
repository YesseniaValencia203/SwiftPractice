//
//  ArticlesViewModel.swift
//  SwiftUIIntroProject
//
//  Created by Consultant on 3/31/22.
//

import Foundation


protocol ArticlesViewModel {
    func getArticles()
}

class ArticlesViewModelImpl: ObservableObject, ArticlesViewModel {
    private let service: ArticlesService
}
