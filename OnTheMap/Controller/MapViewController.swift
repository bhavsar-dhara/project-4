//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-01-11.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.getStudentLocation(completion: handleStudentResponse(success:error:))
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self

        // TODO Set initial location in Honolulu
//        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
//        mapView.centerToLocation(initialLocation)
    }
    
    @IBAction func logoutClick(_ sender: UIButton) {
        APIClient.logout()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshClick(_ sender: UIButton) {
        APIClient.getStudentLocation(completion: handleStudentResponse(success:error:))
    }
    
    func handleStudentResponse(success: [StudentInformation]?, error: Error?) {
        if success != nil {
            print("MapVC: ", success?.count ?? 0)
            LocationModel.locationList = success!
            // TODO
            var mapPoint: MapModel!
            success?.forEach { info in
                mapPoint = MapModel(name: info.firstName + " " + info.lastName, latitude: Double(info.latitude), longitude: Double(info.longitude), url: info.mapString)
                MapLocationModel.locationList.append(mapPoint)
            }
            mapView.addAnnotations(MapLocationModel.locationList)
        } else {
            print("MapVC: ", error?.localizedDescription ?? "")
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard let annotation = annotation as? MapModel else {
            return nil
        }
        var view: MKMarkerAnnotationView
        let identifier = "studentInformation"
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController : CLLocationManagerDelegate {
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
//            let region = MKCoordinateRegion(center: location.coordinate, span: span)
//            mapView.setRegion(region, animated: true)
        }
    }

    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error finding location: \(error.localizedDescription)")
    }
}
