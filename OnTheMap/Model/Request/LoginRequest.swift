//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2021-12-20.
//  Copyright © 2021 Dhara Bhavsar. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    let username: String
    let password: String
}

struct UdacityLoginRequest: Codable {
    
    let udacity: LoginRequest
}
