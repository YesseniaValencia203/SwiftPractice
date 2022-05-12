//
//  UsersTableViewCell.swift
//  PetsFinal
//
//  Created by Consultant on 4/6/22.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        userNameLabel.text = nil
        userIDLabel.text = nil 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
