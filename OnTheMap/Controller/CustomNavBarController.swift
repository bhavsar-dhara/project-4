//
//  CustomNavBarController.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-01-11.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation
import UIKit

class CustomNavBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

protocol DisplayErrorAlert {
    func showErrorDialogBox(message: String)
}
