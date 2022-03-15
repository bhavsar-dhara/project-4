//
//  GaurdDetails.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-03-15.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation

struct GuardDetails: Codable {
    
    let can_edit: Bool
    let permissions: PermissionsDetails
    let allowed_behaviors: [String]
    let subject_kind: String
}
