//
//  ViewController.swift
//  PokemonVersion2
//
//  Created by Consultant on 3/11/22.
//

import UIKit
import CloudKit

class FavoritePokemonViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var refreshListButton: UIButton!
    @IBOutlet weak var favoriteTabItem: UITabBarItem!
    let database = DatabaseHandler()
    var pokemonList: [PokemonEntity]? {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    @IBAction func deleteList(_ sender: Any) {
        emptyStores()
    }

    func emptyStores() {
        pokemonList = database.fetch(PokemonEntity.self)
        for item in (pokemonList)! {
            database.delete(item)
        }
    }
    func reloadFavorites() {
        emptyStores()
        pokemonList = database.fetch(PokemonEntity.self)
        
    }
    func setupDelegates() {
        
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    override func viewDidLoad() {
       // emptyStores()
        super.viewDidLoad()
        setupDelegates()
        tableview.tableFooterView = UIView(frame: .zero)
        view.layer.cornerRadius = 10
        tableview.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
  
    override func viewWillAppear(_ animated: Bool) {
        //APIHandler.shared.syncPokemon {
            self.pokemonList = self.database.fetch(PokemonEntity.self)
       // }
    }
   
    override func viewDidAppear(_ animated: Bool) {
        pokemonList = database.fetch(PokemonEntity.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PokemonDetailsViewController {
            guard let thisPokemon = pokemonList?[(tableview.indexPathForSelectedRow?.row)!] else { return }
            guard let  pokemonURL = URL(string: thisPokemon.url!) else { return }
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
extension FavoritePokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FavoritesTableViewCell
        cell.pokemon = pokemonList?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            print("inserting...")
        case .delete:
            print("deleting...")
            guard let pokemon = pokemonList?[indexPath.row] else { return }
            tableview.beginUpdates()
            pokemonList?.remove(at: indexPath.row)
            database.delete(pokemon)
            tableview.deleteRows(at: [indexPath], with: .automatic)
            tableview.endUpdates()
        default:
            break
        }
        
    }
}
