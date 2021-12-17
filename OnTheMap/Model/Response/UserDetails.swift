//
//  UserDetails.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2021-12-17.
//  Copyright © 2021 Dhara Bhavsar. All rights reserved.
//

import Foundation

struct UserDetails: Codable {
    
    let lastName: String
//    let socialAccounts: []?
    
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
//        case socialAccount = "social_accounts"
    }
}
