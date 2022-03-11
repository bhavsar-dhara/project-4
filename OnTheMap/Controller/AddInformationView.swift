//
//  AddInformationView.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-03-10.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddInformationView: UIViewController {
    
    @IBOutlet weak var worldView: UIImageView!
    @IBOutlet weak var locationView: UITextField!
    @IBOutlet weak var linkView: UITextField!
    @IBOutlet weak var findLocationBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationClick(_ sender: UIButton) {
        
    }

    @IBAction func finishClick(_ sender: UIButton) {
        
    }
    
}
