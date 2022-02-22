//
//  SecondViewController.swift
//  segue
//
//  Created by Admin on 11/18/21.
//

import UIKit

class SecondViewController: UIViewController {
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

