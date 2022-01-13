//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-01-11.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation
import UIKit

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.getStudentLocation(completion: handleStudentResponse(success:error:))
    }
    
    func handleStudentResponse(success: [LocationResult]?, error: Error?) {
        if success != nil {
            print("MapVC", success?.count ?? 0)
        } else {
            print("MapVC", error?.localizedDescription ?? "")
        }
    }
    
}
