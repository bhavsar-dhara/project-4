//
//  TabBarViewController.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-03-15.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController, DisplayErrorAlert {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showErrorDialogBox(message: String) {
        print("navBar: showErrorDialogBox")
        let alertVC = UIAlertController(title: "Error Encountered", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.show(alertVC, sender: nil)
    }
}
