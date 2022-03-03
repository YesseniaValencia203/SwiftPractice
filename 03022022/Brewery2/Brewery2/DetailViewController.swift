//
//  DetailViewController.swift
//  Brewery2
//
//  Created by Consultant on 3/2/22.
//

import UIKit

class DetailViewController: UIViewController {
    var brewery: Brewery?
    @IBOutlet weak var breweryName: UILabel!
    @IBOutlet weak var breweryStreet: UILabel!
    @IBOutlet weak var breweryCityState: UILabel!
    @IBOutlet weak var breweryCountry: UILabel!
    @IBOutlet weak var breweryPhone: UILabel!
    @IBOutlet weak var breweryWebsite: UILabel!
    
    
    override func viewDidLoad() {
        
        breweryName.text = brewery?.name
        breweryStreet.text = brewery?.street ?? ""
        breweryCityState.text = "\(brewery?.city ?? ""), \(brewery?.state ?? "") \(brewery?.postalCode ?? "")"
        breweryCountry.text = brewery?.country ?? ""
        breweryWebsite.text = brewery?.website?.absoluteString
        breweryPhone.text = brewery?.phone ?? ""
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
