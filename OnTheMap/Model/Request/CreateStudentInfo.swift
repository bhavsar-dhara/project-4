//
//  CreateStudentInfo.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-03-12.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation

struct CreateStudentInfo: Codable {
    
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Float
    let longitude: Float
}
