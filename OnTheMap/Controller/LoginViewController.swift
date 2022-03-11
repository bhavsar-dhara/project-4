//
//  ViewController.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2021-10-15.
//  Copyright © 2021 Dhara Bhavsar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupTextView: UITextView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.text = ""
        password.text = ""
        
        let attributedString = NSMutableAttributedString(string: "Don't have an account? Sign Up")
        let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com")!

        // Set the 'click here' substring to be the link
        attributedString.setAttributes([.link: url], range: NSMakeRange(23, 7))

        self.signupTextView.attributedText = attributedString
        self.signupTextView.isUserInteractionEnabled = true
        self.signupTextView.isEditable = false
        self.signupTextView.textAlignment = .center

        // Set how links should appear: blue and underlined
        self.signupTextView.linkTextAttributes = [
            .foregroundColor: UIColor.blue
        ]
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            UIApplication.shared.open(URL) { success in
                if success {
                    print("The URL was delivered successfully.")
                } else {
                    print("The URL failed to open.")
                }
            }
            return false
        }
    
    @IBAction func signUp(url: String) {
//        TODO
        if let appURL = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com") {
            UIApplication.shared.open(appURL) { success in
                if success {
                    print("The URL was delivered successfully.")
                } else {
                    print("The URL failed to open.")
                }
            }
        } else {
            print("Invalid URL specified.")
        }
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        setLoggingIn(true)
        
        guard email.text != nil else {
            print("email not provided")
            showLoginFailure(message: "Please enter a value for email")
            return
        }
        
        guard password.text != nil else {
            print("password not entered")
            showLoginFailure(message: "Please enter a value for password")
            return
        }
        
        APIClient.login(username: email.text ?? "", password: password.text ?? "", completion: handleLoginResponse(success:error:))
    }
    
    func handleLoginResponse(success: LoginResponse?, error: Error?) {
        setLoggingIn(false)
        if success?.sessionDetails != nil {
            print("handleLoginResponse: result obtained")
            email.text = ""
            password.text = ""
            performSegue(withIdentifier: "completeLogin", sender: self)
        } else if success?.errorResponse != nil {
            print("handleLoginResponse: error received from API")
            showLoginFailure(message: success?.errorResponse.error ?? "")
        } else {
            print("handleLoginResponse: error: ", error!)
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
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

