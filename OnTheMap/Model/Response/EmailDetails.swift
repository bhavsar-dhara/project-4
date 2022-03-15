//
//  EmailDetails.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-03-15.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation

struct EmailDetails: Codable {
    
    let address: String
    let _verified: Bool
    let _verification_code_sent: Bool
}
