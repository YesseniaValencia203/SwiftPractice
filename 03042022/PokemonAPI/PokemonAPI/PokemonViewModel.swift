//
//  PokemonViewModel.swift
//  PokemonAPI
//
//  Created by Consultant on 3/4/22.
//

import Foundation

protocol PokemonViewModelDelegate: AnyObject {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class PokemonViewModel {
    /*
     
     */
    private weak var delegate: PokemonViewModelDelegate?
    private lazy var baseURL: URL = {
        return URL(string: "\(APIEndpoints.pokemonAPI)pokemon")!
    }()
    var pokemonResults: [PokemonPage]
    
    private var pokemons: [Pokemon]
    private var pokemonRequest: PokemonRequest
    private var total = 0
    private var isFetchingInProgress = false
    init(delegate: PokemonViewModelDelegate) {
        self.delegate = delegate
        self.pokemons = [Pokemon]()
        self.pokemonResults = [PokemonPage]()
    }
    
    var totalCount: Int { return total }
    var currentCount: Int { return pokemons.count }
    func pokemon(at index: Int) -> Pokemon {
        return pokemons[index]
    }
    func fetchPokemonResults() {
        URLSession.shared.getRequest(url: baseURL, decoding: Page.self) { [ weak self ] result in
            switch result {
            case .success(let page):
                print(page.results!)
                self?.pokemonResults = page.results!
            case .failure(let error):
                print(error)
            }
        }
        
    }
    func fetchPokemon() {
        fetchPokemonResults()
        for thisPokemon in pokemonResults {
            URLSession.shared.getRequest(url: thisPokemon.url, decoding: Pokemon.self) { [weak self] result in
                switch result {
                case .success(let poke):
                    print(poke.id!)
                    self?.pokemons.append(poke)
                case .failure(let error):
                    DispatchQueue.main.async
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    

    /*
     Calculates the index path for the last page of pokemon received from the API. You'll use this to refresh only the content that's changed
     */
    private func calculateIndexPathsToReload(from newPokemon: [Pokemon]) -> [IndexPath] {
        let startIndex = pokemons.count - newPokemon.count
        let endIndex = startIndex + newPokemon.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
