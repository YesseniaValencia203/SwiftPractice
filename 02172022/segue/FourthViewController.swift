//
//  FourthViewController.swift
//  
//
//  Created by Consultant on 2/21/22.
//

import UIKit

class FourthViewController: UIViewController {
    var mySegue = "mySegue"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func next(_ sender: Any) {
        //perform segue
        performSegue(withIdentifier: mySegue, sender: nil)
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
