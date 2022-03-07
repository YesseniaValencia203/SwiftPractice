//
//  PokemonViewModel.swift
//  PokemonAPI
//
//  Created by Consultant on 3/4/22.
//

import Foundation
import UIKit

protocol PokemonViewModelDelegate: AnyObject {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}
final class PokemonModel {
    private weak var delegate: PokemonViewModelDelegate?
    var pokemonResults = [PokemonPage]()
    var pokemonPages = [PageResult]()
    var total = 150
    var currentCount: Int {
        return pokemonResults.count
    }
    private var isFetchInProgress = false
    private var currentPage = 1
        init(delegate: PokemonViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchPokemons() {
        guard !isFetchInProgress else { return }
        guard currentCount != total else { return }
        isFetchInProgress = true
        var path: URL
        if currentPage == 1 {
            path = URL(string: (APIEndpoints.pokemonAPI))!
        } else {
            path = (pokemonPages.last?.next)!
        }
        URLSession.shared.getRequest(url: path, decoding: PageResult.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.currentPage += 1
                    self?.isFetchInProgress = false
                    self?.pokemonResults.append(contentsOf: response.results!)
                    self?.pokemonPages.append(response)
                    print((self?.currentCount)!)
                    print((response.results?.count)!)
                    
                    if response.previous != nil {
                        let indexPathsToReload = self?.calculateIndexPathsToReload(from: response.results!)
                        self?.delegate?.onFetchCompleted(with: indexPathsToReload!)
                    } else {
                        self?.delegate?.onFetchCompleted(with: .none)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isFetchInProgress = false
                    self?.delegate?.onFetchFailed(with: error.localizedDescription)
                    print("PokemonModel:fetchPokemons: \(error.localizedDescription)")
                }
            }
        }
        
    }
    private func calculateIndexPathsToReload(from newPokemon: [PokemonPage]) -> [IndexPath] {
        let startIndex = pokemonResults.count - newPokemon.count
        let endIndex = startIndex + newPokemon.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0)}
    }
}

