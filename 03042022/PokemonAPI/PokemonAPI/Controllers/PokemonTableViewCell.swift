//
//  PokemonDetailsTableViewCell.swift
//  PokemonAPI
//
//  Created by Consultant on 3/4/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var pokemonView: UIView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonType: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configurePokemonCell(with: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pokemonView.backgroundColor = .darkGray
}
    
    func configurePokemonCell(with pokemonProfile: PokemonProfile?) {
        
        if let pokemonProfile = pokemonProfile {
            isUserInteractionEnabled = true 
            pokemonImage.getImage(from: (pokemonProfile.sprites?.front_default)!, contentMode: .scaleAspectFill)
            pokemonView.backgroundColor = .white
            pokemonName.alpha = 1
            pokemonView.alpha = 1
            pokemonType.alpha = 1
            pokemonImage.alpha = 1
            var typeString = "Type: "
            for pokeType in (pokemonProfile.pokemonTypes)! {
                typeString += "\((pokeType.type?.name)!.capitalized) "
            }
            pokemonType.text = typeString
            pokemonName.text = pokemonProfile.name?.capitalized

        } else {
            pokemonView.backgroundColor = .lightGray
            pokemonName.alpha = 0
            pokemonView.alpha = 0
            pokemonImage.alpha = 0
            pokemonType.alpha = 0
        }
    }
    
    
    
    
}
