//
//  LocationResult.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2021-12-17.
//  Copyright © 2021 Dhara Bhavsar. All rights reserved.
//

import Foundation

struct LocationResult: Codable {
    
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Float
    let longitude: Float
    let createdAt: Date
    let updatedAt: Date
}
