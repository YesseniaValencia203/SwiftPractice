//
//  DetailsViewController.swift
//  TopAlbums
//
//  Created by Consultant on 2/27/22.
//

import UIKit

class DetailsViewController: UIViewController {
    var artistImage: UIImage
    var artistLabel: UILabel
    var artistDetails: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        artistImage = UIImage()
        artistLabel = UILabel()
        
        view.addSubview(artistImage)
        view.addSubview(artistLabel)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
