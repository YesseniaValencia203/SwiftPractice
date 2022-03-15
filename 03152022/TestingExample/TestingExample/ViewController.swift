//
//  ViewController.swift
//  TestingExample
//
//  Created by Consultant on 3/15/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    private let secondVC = "secondVC"
    
    private let validation: ValidationService
    private let dummyUser = [User(username: "admin", password: "password")]
    
    init(validation: ValidationService) {
        self.validation = validation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.validation = ValidationService()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
    }

    @IBAction func loginTapped(_ sender: Any) {
        
        do {
            let username = try validation.validateUserName(usernameTextField.text)
            let password = try validation.validatePassword(passwordTextField.text)
            
            if usernameTextField.text == username &&
                passwordTextField.text == password {
                navigateNext()
            }
            
        } catch {
            print("Not valid")
            
        }
    }
    private func navigateNext() {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
}

