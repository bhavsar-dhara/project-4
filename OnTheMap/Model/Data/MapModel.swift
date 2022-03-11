//
//  MapModel.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-03-09.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation
import MapKit

class MapModel: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    var info: String
    
    init(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, location: String, url: String) {
        self.title = name
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.subtitle = location
        self.info = url
    }
}
