//
//  PokemonDetailsTableViewCell.swift
//  PokemonAPI
//
//  Created by Consultant on 3/4/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    var pokemonProfile: PokemonProfile?
    @IBOutlet weak var pokemonView: UIView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonType: UILabel!
    var favoriteButton: UIButton = UIButton(type: .custom)
    var pokemonURL: URL?
    var name: String?
    var currentFavorite: Bool = false
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        configurePokemonCell(with: .none)
    }
    
    @objc func tapButton() {
        guard let name = name, let pokemonURL = pokemonURL else { return }
        let pokemon = PokemonServerModel(name: name, url: pokemonURL)
        if currentFavorite {
           
            
            currentFavorite = false
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            pokemon.store()
            currentFavorite = true
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pokemonView.backgroundColor = .darkGray
    }
    
    func configurePokemonCell(with pokemonProfile: PokemonProfile?) {
        if let pokemonProfile = pokemonProfile {
            isUserInteractionEnabled = true
            pokemonView.backgroundColor = .white
            pokemonName.alpha = 1
            pokemonView.alpha = 1
            pokemonType.alpha = 1
            pokemonImage.alpha = 1
            pokemonImage.getImage(from: (pokemonProfile.sprites?.front_default)!, contentMode: .scaleAspectFill)
            var typeString = "Type: "
            for pokeType in (pokemonProfile.pokemonTypes)! {
                typeString += "\((pokeType.type?.name)!.capitalized) "
            }
            pokemonType.text = typeString
            pokemonName.text = pokemonProfile.name?.capitalized
            favoriteButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
            
        } else {
            pokemonView.backgroundColor = .lightGray
            pokemonName.alpha = 0
            pokemonView.alpha = 0
            pokemonImage.alpha = 0
            pokemonType.alpha = 0
        }
    }
    
    
    
    
}
