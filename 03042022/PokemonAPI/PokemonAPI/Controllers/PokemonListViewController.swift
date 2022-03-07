//
//  ViewController.swift
//  PokemonAPI
//
//  Created by Consultant on 3/4/22.
//

import UIKit


class PokemonListViewController: UIViewController {
    private var viewModel: PokemonModel!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.prefetchDataSource = self
        viewModel = PokemonModel(delegate: self)
        viewModel.fetchPokemons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PokemonDetailsViewController {
            let thisPokemon = viewModel.pokemonResults[(tableview.indexPathForSelectedRow?.row)!]
            let pokemonURL = thisPokemon.url
            destination.navigationItem.title = thisPokemon.name!.capitalized
            URLSession.shared.getRequest(url: pokemonURL, decoding: PokemonProfile.self) { results in
                switch results {
                case .success(let pokemonProfile):
                    DispatchQueue.main.async {
                        //destination.navigationItem.title = pokemonProfile.name!.capitalized
                        destination.pokemonIcons.layer.borderWidth = 0.3
                        destination.pokemonImage.getImage(from: (pokemonProfile.sprites?.front_default)!, contentMode: .scaleAspectFit)
                        destination.pokemonImage2.getImage(from: (pokemonProfile.sprites?.back_default)!, contentMode: .scaleAspectFit)
                        var typesString = "Type: "
                        for pokemonType in (pokemonProfile.pokemonTypes)! {
                            typesString += "\((pokemonType.type?.name)!.capitalized) "
                        }
                        destination.pokemonTypes.text = typesString
                        for pokemonAbility in (pokemonProfile.abilities)! {
                            destination.pokemonAbilities.text += "\((pokemonAbility.ability?.name)!.capitalized)\n"
                        }
                        //destination.pokemonTypes.layer.borderWidth = 0.6
                        destination.pokemonMoves.layer.borderWidth = 0.3
                        destination.pokemonAbilities.layer.borderWidth = 0.3
                        for pokemonMove in (pokemonProfile.moves)! {
                            destination.pokemonMoves.text += "\((pokemonMove.move?.name)!.capitalized)\n"
                        }
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
        return viewModel.total
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonTableViewCell
        if isLoadingCell(for: indexPath) {
            //cell.configureCell(with: .none)
        } else {
            
            let poke = viewModel.pokemonResults[indexPath.row]
            //cell.pokemonImage.getImage(from: (poke.sprites?.front_default)!)
            //cell.configureCell(with: poke)
            URLSession.shared.getRequest(url: poke.url, decoding: PokemonProfile.self) {  pokemonResult in
                switch pokemonResult {
                case .success(let thisPokemon):
                    DispatchQueue.main.async {
                        cell.pokemonImage.getImage(from: (thisPokemon.sprites?.front_default)!, contentMode: .scaleAspectFill)
                        cell.pokemonName.text = thisPokemon.name?.capitalized
                        var typeString = "Type: "
                        for pokeType in (thisPokemon.pokemonTypes)! {
                            typeString += "\((pokeType.type?.name)!.capitalized) "
                        }
                        cell.pokemonType.text = typeString
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
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchPokemons()
        }
    }
}
extension PokemonListViewController: PokemonViewModelDelegate {
    func onFetchFailed(with reason: String) {
        print("onFetchFailed")
        
    }
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            tableview.isHidden = false
            tableview.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableview.reloadRows(at: indexPathsToReload, with: .automatic)
    }
}


private extension PokemonListViewController {
    /*
     Allows you to determine whether the cell at that index path is beyond the count of the pokemons you have received so far
     */
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    /*
     This method calculates the cells of the table view that you need to reload when you receive a new page. It calculates the intersection of the IndexPaths passes in (previously calcylated by the view model) with the visible ones. You'll use this to avoid refreshing cells that are not currently visible on the screen
     */
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableview.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
