//
//  WatchlistTableViewCell.swift
//  PetsFinal
//
//  Created by Consultant on 4/6/22.
//

import UIKit

class WatchlistTableViewCell: UITableViewCell {
  
    @IBOutlet weak var petNameLabel: UILabel!
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    var pet: Pet? {
        didSet {
            setupCell()
        }
    }
    
    private func setupCell() {
        guard let pet = pet else {
            return
        }
        petNameLabel.text = pet.name
        isUserInteractionEnabled = true
        
        let allUsers = DatabaseHandler.shared.fetch(User.self)
        for thisUser in allUsers {
            if thisUser.id == pet.ownerID {
                ownerNameLabel.text = thisUser.firstName.capitalized
            }
        }

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
