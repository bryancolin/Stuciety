//
//  LoginViewController.swift
//  Stuciety
//
//  Created by bryan colin on 3/16/21.
//

import UIKit
import Firebase
import ProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: CustomUITextField! {
        didSet {
            emailTextField.tag = 0
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: CustomUITextField! {
        didSet {
            passwordTextField.tag = 1
            passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(_ sender: CustomUIButton) {
        
        ProgressHUD.show()
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return ProgressHUD.showError("Something went wrong. Please try again")
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error, let errorCode = AuthErrorCode(rawValue: e._code) {
                switch errorCode {
                case .invalidEmail:
                    ProgressHUD.showFailed("Invalid email. Please try again.")
                case .wrongPassword:
                    ProgressHUD.showFailed("Wrong password. Please try again.")
                case .networkError:
                    ProgressHUD.showFailed("Network error. Please try again.")
                default:
                    ProgressHUD.showFailed("Unknown error occurred")
                }
            } else {
                self.performSegue(withIdentifier: K.Segue.login, sender: self)
                ProgressHUD.dismiss()
            }
        }
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tagBasedTextField(textField)
        return true
    }
    
    private func tagBasedTextField(_ textField: UITextField) {
        let nextTextFieldTag = textField.tag + 1
        
        if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
}
