import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let petsVC = "TabViewController"
    private let validation: ValidationService
    private let dummyUser = [UserAccount(username: "admin", password: "password")]
    
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
        configureFields()
    }
    
    func configureFields() {
        passwordTextField.isSecureTextEntry = true
    }

    @IBAction func loginTapped(_ sender: Any) {
        do {
            let username = try validation.validateUserName(usernameTextField.text)
            let password = try validation.validatePassword(passwordTextField.text)
            
            if usernameTextField.text == username && passwordTextField.text == password {
                navigateNext()
            }
        } catch {
            print("Invalid username/password.")
        }
    }
    
    private func navigateNext() {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: petsVC) as! ViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
}
