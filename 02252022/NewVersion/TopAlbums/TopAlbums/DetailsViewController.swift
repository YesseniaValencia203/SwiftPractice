//
//  DetailsViewController.swift
//  TopAlbums
//
//  Created by Consultant on 3/8/22.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var artistImage: UIImageView!
    var album: Album?

    @IBOutlet weak var artistDetails: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        artistImage.image = album?.artistImage
        artistDetails.text = album?.artistDetails
        title = album?.artistName

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
