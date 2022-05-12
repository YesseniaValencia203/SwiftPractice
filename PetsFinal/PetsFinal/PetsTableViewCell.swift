//
//  PetsTableViewCell.swift
//  PetsFinal
//
//  Created by Consultant on 4/6/22.
//

import UIKit

class PetsTableViewCell: UITableViewCell {

    @IBOutlet weak var petsBreedLabel: UILabel!
    @IBOutlet weak var petsNameLabel: UILabel!
    var pet: AnimalResponse?
    var currentFavorite: Bool = false
    
    var favoriteButton: UIButton = UIButton(type: .custom)
    
    @IBOutlet weak var petsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @objc func tapButton() {
        guard let pet = pet else {
            return
        }
        
        if currentFavorite {
            let allFavorites = DatabaseHandler.shared.fetch(Pet.self)
            for fav in allFavorites {
                if fav.id == pet.id! {
                    DatabaseHandler.shared.delete(fav)
                    currentFavorite = false
                    favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    return
                }
            }
        } else {
            let allFavorites = DatabaseHandler.shared.fetch(Pet.self)
            for fav in allFavorites {
                if fav.id == pet.id! {
                    currentFavorite = true
                    favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    return
                }
            }
            let thisPet = PetServerModel(id: pet.id!, ownerID: 0, name: pet.name!, age: pet.age!, gender: pet.gender!, species: pet.species!)
            thisPet.store()
            currentFavorite = true
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            return
            
            
        }
        

    }
    
    func configureFavorites() {
        if let pet = pet {
            let favorites = DatabaseHandler.shared.fetch(Pet.self)
            for fav in favorites {
                if fav.id == pet.id! {
                    currentFavorite = true
                    favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                }
            }
        }
        favoriteButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }

}
