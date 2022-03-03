//
//  DetailViewController.swift
//  BreweryAPI
//
//  Created by Consultant on 3/1/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var breweryName: UILabel!
    @IBOutlet weak var breweryStreet: UILabel!
    
    @IBOutlet weak var breweryCity: UILabel!
    @IBOutlet weak var breweryCountry: UILabel!
    @IBOutlet weak var breweryPhone: UILabel!
    
    var name : String = ""
    var address: String = ""
    var phone: String = ""
    var street: String = ""
    var city: String = ""
    var country: String = ""
    
    
    override func viewDidLoad() {
        breweryName.text = name
        breweryPhone.text = phone
        breweryStreet.text = street
        breweryCity.text = city
        breweryCountry.text = country
        breweryPhone.text = phone
        configureConstraints()
        
        
        super.viewDidLoad()
    }
    

    
    func configureConstraints() {
        breweryName.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        breweryCity.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        breweryPhone.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        breweryCountry.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        breweryStreet.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    

}
