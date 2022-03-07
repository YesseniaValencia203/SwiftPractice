//
//  PokemonDetailsViewController.swift
//  PokemonAPI
//
//  Created by Consultant on 3/4/22.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

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
    }


}
