//
//  LoginViewController.swift
//  KitmanLabs
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var authService = AuthenticationService()
    var authenticatedUser: String?
    
    private let navigationControllerIdentifier = "navigationController"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        errorMessage.isHidden = true
        activityIndicator.isHidden = true
    }
    
    @IBAction func signIn(_ sender: Any) {
        activityIndicator.isHidden = false
        signInButton.isEnabled = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        let username = usernameField.text, password = passwordField.text
        
        if let username = username, let password = password {
            authService.userSignIn(username: username, password: password) { result in
                switch result {
                case .success(let user):
                    self.authenticatedUser = user.username
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else {
                            return
                        }
                        self.activityIndicator.stopAnimating()
                        let navigationVC = storyboard.instantiateViewController(withIdentifier: self.navigationControllerIdentifier) as! UINavigationController
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(navigationVC)
                    }

                case .failure(_):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else {
                            return
                        }
                        self.errorMessage.isHidden = false
                        self.activityIndicator.stopAnimating()
                        self.signInButton.isEnabled = true
                    }
                }
                
            }
        }
        
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
