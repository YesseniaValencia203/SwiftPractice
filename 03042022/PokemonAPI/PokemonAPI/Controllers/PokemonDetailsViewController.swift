//
//  PokemonDetailsViewController.swift
//  PokemonAPI
//
//  Created by Consultant on 3/4/22.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var pokemonProfile: PokemonProfile?
    @IBOutlet weak var pokemonTypesStack: UIStackView!
    @IBOutlet weak var pokemonAbilities: UITextView!
    @IBOutlet weak var pokemonTypes: UILabel!
    
    @IBOutlet weak var pokemonMoves: UITextView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var detailsNavigationItem: UINavigationItem!
    
    @IBOutlet weak var pokemonImage2: UIImageView!
    @IBOutlet weak var pokemonIcons: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true 
        activityIndicator.startAnimating()
    }
    
    func configureDetailsView() {
        guard let pokemonProfile = pokemonProfile else {
            print("PokemonDetailsViewController:configureDetailsView")
            return
        }
        activityIndicator.stopAnimating()
        pokemonIcons.layer.borderWidth = 0.3
        pokemonImage.getImage(from: (pokemonProfile.sprites?.front_default)!, contentMode: .scaleAspectFit)
        pokemonImage2.getImage(from: (pokemonProfile.sprites?.back_default)!, contentMode: .scaleAspectFit)
        var typesString = "Type: "
        for pokemonType in (pokemonProfile.pokemonTypes)! {
            typesString += "\((pokemonType.type?.name)!.capitalized) "
        }
        pokemonTypes.text = typesString
        for pokemonAbility in (pokemonProfile.abilities)! {
            pokemonAbilities.text += "\((pokemonAbility.ability?.name)!.capitalized)\n"
        }
        pokemonMoves.layer.borderWidth = 0.3
        pokemonAbilities.layer.borderWidth = 0.3
        for pokemonMove in (pokemonProfile.moves)! {
            pokemonMoves.text += "\((pokemonMove.move?.name)!.capitalized)\n"
        }
        
    }


}
