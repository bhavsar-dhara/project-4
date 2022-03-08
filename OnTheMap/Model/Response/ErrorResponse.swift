//
//  ErrorResponse.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-03-08.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    
    let status: Int
    let error: String
}
