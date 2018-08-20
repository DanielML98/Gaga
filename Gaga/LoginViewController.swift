//
//  LoginViewController.swift
//  Gaga
//
//  Created by Daniel Martínez on 20/05/22.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
  @IBOutlet weak var userTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBAction func signInButton(_ sender: Any) {
    Auth.auth().signIn(withEmail: self.userTextField.text!, password: self.passwordTextField.text!) { result, error in
      if error != nil {
        print("There has been an error with your credentials")
      }
      print("Everything is in order")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if Auth.auth().currentUser != nil {
      guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainTableView") as? ViewController else { return }
      show(vc, sender: self)
    }
  }
}
