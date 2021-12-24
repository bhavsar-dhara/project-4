//
//  UserDetails.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2021-12-17.
//  Copyright © 2021 Dhara Bhavsar. All rights reserved.
//

import Foundation

struct UserDetails: Codable {
    
    let firstName: String
    let lastName: String
    let hasPassword: Bool
    let registered: Bool
    let imageURL: String
//    let socialAccounts: []?
    
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case hasPassword = "_has_password"
        case registered = "_regsitered"
        case imageURL = "_image_url"
//        case socialAccount = "social_accounts"
    }
}
