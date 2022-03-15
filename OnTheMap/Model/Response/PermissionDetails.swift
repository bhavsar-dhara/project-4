//
//  PermissionDetails.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-03-15.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation

struct PermissionsDetails: Codable {
    
    let derivation: [String]?
    let behavior: String
    let principal_ref: GroupRefDetails
}
