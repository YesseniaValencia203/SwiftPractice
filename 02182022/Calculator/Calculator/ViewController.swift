//
//  ViewController.swift
//  Calculator
//
//  Created by Consultant on 2/27/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numLabel: UILabel!
    var add = false
    var subtract = false
    var multiply = false
    var divide = false
    
    var nextNum : Double = 0
    var prevNum : Double = 0
    var currentlyCalculating : Bool = false
    
    @IBAction func calcOperations(_ sender: UIButton) {
        prevNum = Double(numLabel.text!)!
        
        switch(sender.tag) {
        case 18:
            // divide
            divide = true
            numLabel.text = "/"
        case 11:
            // clear input
            numLabel.text = "0"
            prevNum = 0
            nextNum = 0
            
        case 15:
            // add
            add = true
            numLabel.text = "+"
        
        case 16:
            // subtract
            subtract = false
            numLabel.text = "-"
        case 17:
            // multiply
            multiply = false
            numLabel.text = "*"
        case 14:
            // equals button
            if add == true {
                numLabel.text = String( prevNum + nextNum )
                add = false
            } else if subtract == true {
                numLabel.text = String(prevNum - nextNum)
                subtract = false
            } else if multiply == true {
                numLabel.text = String(nextNum * prevNum)
                multiply = false
            } else if divide == true {
                numLabel.text = String(prevNum / nextNum)
                divide = false
            } else {
                numLabel.text = "0"
            }
            
        default:
            numLabel.text = ""
        
        }
    }
    @IBAction func calcNumbers(_ sender: UIButton) {
        // are we just adding a number to the current string of numbers
        // or are we going to begin calculating the result of the operation
        if currentlyCalculating {
            numLabel.text = String(sender.tag - 1)
            nextNum = Double(numLabel.text!)!
            currentlyCalculating = false
        } else {
            numLabel.text = numLabel.text! + String(sender.tag - 1)
            nextNum = Double(numLabel.text!)!
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

