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
import CoreLocation

class AddInformationView: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var worldView: UIImageView!
    @IBOutlet weak var locationView: UITextField!
    @IBOutlet weak var linkView: UITextField!
    @IBOutlet weak var findLocationBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var coordinate: CLLocationCoordinate2D!
    var userDetails: UserDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIClient.getUserDetails(completion: self.handleUserDetailsFetched(success:error:))
        
        mapView.delegate = self
    }
    
    @IBAction func cancelClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationClick(_ sender: UIButton) {
        let address = locationView.text!
        
        CLGeocoder().geocodeAddressString(address, completionHandler: { placemarks, error in
            if (error != nil) {
                print("Unable to Forward Geocode Address: ", error!)
                // -> notify user
                self.showErrorAlert(title: "Geocoding Failed", message: error?.localizedDescription ?? "")
                self.activityIndicatorView.stopAnimating()
                self.findLocationBtn.isEnabled = true
                return
            } else {
                var location: CLLocation?
                        if let placemarks = placemarks, placemarks.count > 0 {
                            location = placemarks.first?.location
                        }
                        if let location = location {
                            let coordinate = location.coordinate
                            print("\(coordinate.latitude), \(coordinate.longitude)")
                            self.coordinate = coordinate
                            
                            self.worldView.isHidden = true
                            self.locationView.isHidden = true
                            self.linkView.isHidden = true
                            self.findLocationBtn.isHidden = true
                            self.activityIndicatorView.stopAnimating()
                            self.activityIndicatorView.isHidden = true
                            
                            self.finishBtn.isHidden = false
                            self.mapView.isHidden = false
                            self.view.bringSubviewToFront(self.finishBtn)
                            
                            // show location on the mapView
                            let initialLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            let mapPoint = MapModel(name: String(self.locationView.text ?? ""), latitude: Double(coordinate.latitude), longitude: Double(coordinate.longitude), location: String(self.locationView.text ?? ""), url: String(self.locationView.text ?? ""))
                            self.mapView.addAnnotation(mapPoint)
                            self.mapView.centerToLocation(initialLocation)
                        } else {
                            print("No Matching Location Found")
                            // TODO
                            self.showErrorAlert(title: "Geocoding Failed", message: "No matching Location found. Please retry.")
                        }
            }
        })
        
        // Update View
        findLocationBtn.isEnabled = false
        activityIndicatorView.startAnimating()
    }

    @IBAction func finishClick(_ sender: UIButton) {
        print("onFinishClick")
        APIClient.postStudentLocation(firstName: userDetails.firstName, lastName: userDetails.lastName, mapString: String(self.locationView.text ?? ""), mediaURL: String(self.linkView.text ?? ""), latitude: Float(coordinate.latitude), longitude: Float(coordinate.longitude), completion: self.handlePostCreationResponse(success:error:))
    }
    
    func handlePostCreationResponse(success: LocationCreation?, error:Error?) {
        if success != nil {
            print("AddInfoVC: ", success ?? "")
            self.dismiss(animated: true, completion: nil)
        } else {
            print("AddInfoVC: ", error?.localizedDescription ?? "")
            // TODO
            showErrorAlert(title: "Error while creating new student location", message: error?.localizedDescription ?? "")
        }
    }
    
    func handleUserDetailsFetched(success: UserDetails?, error: Error?) {
        if success != nil {
            print("AddInfoVC: user details: ", success ?? "")
            userDetails = success
        } else {
            print("AddInfoVC: error fetching user details: ", error?.localizedDescription ?? "")
        }
    }
    
    func showErrorAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 10000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
