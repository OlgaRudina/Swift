//
//  RegisterViewController.swift
//  Flash Chat iOS13


import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text{
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error{
                let alert = UIAlertController(title: "Registration failed", message: e.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                //Navigate to the chat view controller
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
            }
        }
        }
    }
    
}
