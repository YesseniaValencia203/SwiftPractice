//
//  TableViewCell.swift
//  DotaCodable
//
//  Created by Consultant on 3/9/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    var hero: Hero?
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    var button: UIButton?
    var isFavorite: Bool?
    

    @objc func buttonPushed(tag: Int) {
        isFavorite = (isFavorite)! ? false : true
        UserDefaults.standard.set(isFavorite, forKey: String(tag))
        updateUI(isFavorite: isFavorite!)
        
    }
    override func awakeFromNib() {
    
        
    }
    func configureCell(tag: Int) {
        button = UIButton(type: .custom)
        button?.setImage(UIImage(systemName: "star"), for: .normal)
        button?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button?.addTarget(self, action: #selector(buttonPushed(tag:)), for: .touchUpInside)
        isFavorite = UserDefaults.standard.bool(forKey: String(tag))
        cellTitle?.text = hero?.name.capitalized
        accessoryView = button! as UIView
        updateUI(isFavorite: isFavorite!)
        
        
        
        
        
        
    }
    @IBAction func sliderChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: String(sender.tag))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    private func updateUI(isFavorite: Bool) {
        if isFavorite {
            button?.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            button?.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    
}
