//
//  ViewController.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2021-10-15.
//  Copyright © 2021 Dhara Bhavsar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupTextView: UITextView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        email.text = ""
        password.text = ""
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        setLoggingIn(true)
        APIClient.login(username: email.text ?? "", password: password.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    func handleLoginResponse(success: SessionDetails?, error: Error?) {
        if success != nil {
            print("result obtained")
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
         setLoggingIn(false)
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
        email.isEnabled = !loggingIn
        password.isEnabled = !loggingIn
        loginBtn.isEnabled = !loggingIn
//        TODO - change to a button
//        signupTextView.isEnabled = !loggingIn
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}

