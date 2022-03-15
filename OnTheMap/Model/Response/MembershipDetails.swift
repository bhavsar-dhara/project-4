//
//  MembershipDetails.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-03-15.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation

struct MembershipDetails: Codable {
    
    let current: Bool
    let group_ref: GroupRefDetails
    let creation_time: String?
    let expiration_time: String?
}
