//
//  ViewController.swift
//  PokemonAPI
//
//  Created by Consultant on 3/4/22.
//

import UIKit

protocol PokemonViewModelDelegate: AnyObject {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    private weak var delegate: PokemonViewModelDelegate?
   
    var pokemonResults = [PokemonPage]()
    var pokemonPages = [PageResult]()
    var total = 150
    var currentCount: Int {
        return pokemonResults.count
    }
    private var isFetchInProgress = false
    private var currentPage = 1
        
    override func viewDidLoad() {
        self.tabBarController?.navigationItem.title = "All Pokemons"

        super.viewDidLoad()
        tableview.dataSource = self
        tableview.prefetchDataSource = self
        tableview.delegate = self
        fetchPokemons()
    }
    func fetchPokemons() {
        // Prevents more than a single call to the PAI
        guard !isFetchInProgress else { return }
        // Prevents more than 150 pokemon being loaded
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
                    if response.previous != nil {
                        let indexPathsToReload = self?.calculateIndexPathsToReload(from: response.results!)
                        self?.delegate?.onFetchCompleted(with: indexPathsToReload!)
                    } else {
                        self?.tableview.reloadData()
                        self?.delegate?.onFetchCompleted(with: .none)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isFetchInProgress = false
                    self?.delegate?.onFetchFailed(with: error.localizedDescription)
                    print("fetchPokemon(): \(error.localizedDescription)")
                }
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PokemonDetailsViewController {
            let thisPokemon = pokemonResults[(tableview.indexPathForSelectedRow?.row)!]
            let pokemonURL = thisPokemon.url
            destination.navigationItem.title = thisPokemon.name!.capitalized
            URLSession.shared.getRequest(url: pokemonURL, decoding: PokemonProfile.self) { results in
                switch results {
                case .success(let pokemonProfile):
                    DispatchQueue.main.async {
                        destination.pokemonProfile = pokemonProfile
                        destination.configureDetailsView()
                    }
                case .failure(let error):
                    print("PokemonListViewController:prepare: \(error.localizedDescription)")
                }
            }
        }
    }
        
}
extension PokemonListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonTableViewCell
        cell.layer.borderWidth = 0.3
        if isLoadingCell(for: indexPath) {
            cell.configurePokemonCell(with: .none)
        } else {
            let poke = pokemonResults[indexPath.row]
            let pokemonURL = poke.url!
            URLSession.shared.getRequest(url: pokemonURL, decoding: PokemonProfile.self) {  pokemonResult in
                switch pokemonResult {
                case .success(let thisPokemon):
                    DispatchQueue.main.async {
                        cell.pokemonURL = pokemonURL
                        cell.name = thisPokemon.name
                        cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                        cell.favoriteButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                        cell.accessoryView = cell.favoriteButton
                        cell.configurePokemonCell(with: thisPokemon)
                    }
                case .failure(let thisError):
                    print("PokemonListViewController:UITableViewDataSource:UITableViewDelegate: \(thisError.localizedDescription)")
                }
            }
        }
        return cell
    }
    
    
}
extension PokemonListViewController : UITableViewDataSourcePrefetching {
    /*
     This method receives index paths for cells to prefetch based on current scroll direction and speed
     */
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        /*
         As soon as the table view starts to prefetch a list of index paths, it checks if any of those are not loaded yet in the pokemon list. If so, you need to request a new page of pokemon.
         */
        if indexPaths.contains(where: isLoadingCell) {
            fetchPokemons()
        }
    }
}
extension PokemonListViewController: PokemonViewModelDelegate {
    func onFetchFailed(with reason: String) {
        print("Fetching this page has failed")
    }
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            // If newIndexPathsToReload is nil => first page => makes the table view visible and reloads it
            tableview.isHidden = false
            tableview.reloadData()
            return
        }
        // If not nil => next pages => find the visible cells that need realoading and tell the table view to only reload those
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableview.reloadRows(at: indexPathsToReload, with: .automatic)
    }
}
private extension PokemonListViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        /*
         Allows you to determine whether in the cell at that index path is beyond the count of the pokemon you have received so far
         */
        return indexPath.row >= currentCount
    }
    
    private func calculateIndexPathsToReload(from newPokemon: [PokemonPage]) -> [IndexPath] {
        // Calculates the index paths for the last page of pokemon received
        let startIndex = pokemonResults.count - newPokemon.count
        let endIndex = startIndex + newPokemon.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0)}
    }
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        /*
         Calculates the cells of the table view that you need to reload when you receive a new page. It calculates the intersection of the IndexPath(s) passed in with the visible ones.
         Use this to avoid refreshing cells that are not currently visible on the screen
         */
        let indexPathsForVisibleRows = tableview.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}


