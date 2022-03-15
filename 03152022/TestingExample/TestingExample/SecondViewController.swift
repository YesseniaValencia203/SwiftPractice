//
//  SecondViewController.swift
//  TestingExample
//
//  Created by Consultant on 3/15/22.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var userInput: String {
        // computed property
        return (inputTextField.text)!
    }
    var fibNum: Int {
        return Int(userInput)!
        // take string and turn it into integer
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func calcFib(_ sender: Any) {
        guard fibNum > 0 else { return }
        var fibonacci = [0, 1]
        for i in 2...fibNum {
            fibonacci.append(i)
            fibonacci[i] = fibonacci[i-1] + fibonacci[i - 2]
        }
        resultLabel.text = "\(fibonacci)"
    }
    
}
