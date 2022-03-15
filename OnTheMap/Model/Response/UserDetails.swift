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
//    let hasPassword: Bool
//    let registered: Bool
//    let imageURL: String
    let key: String
    let nickname: String
    
//    let social_accounts: [String?] // []
//    let mailing_address: String? // null
//    let _cohort_keys: [String?] // []
//    let signature: String? // null
//    let _stripe_customer_id: String? // null
//    let guard_: GuardDetails? // {}
//    let _facebook_id: String? // null
//    let timezone: String? // null
//    let site_preferences: String? // null
//    let occupation: String? // null
//    let _image: String? // null
//    let jabber_id: String? // null
//    let languages: String? // null
//    let _badges: [String?] // []
//    let location: String? // null
//    let external_service_password: String? // null
//    let _principals: [String?] // []
//    let _enrollments: [String?] // []
//    let email: EmailDetails
//    let website_url: String? // null
//    let external_accounts: [String?] // []
//    let bio: String? // null
//    let coaching_data: String? // null
//    let tags: [String?] // []
//    let _affiliate_profiles: [String?] // []
//    let email_preferences: EmailPrefsDetails? // {}
//    let _resume: String? // null
//    let employer_sharing: Bool
//    let _memberships: [MembershipDetails?] // [{}]
//    let zendesk_id: String?
//    let _registered: Bool
//    let linkedin_url: String?
//    let _google_id: String?
    
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
//        case hasPassword = "_has_password"
//        case registered = "_regsitered"
//        case imageURL = "_image_url"
        case key
        case nickname
        
//        case social_accounts
//        case mailing_address
//        case _cohort_keys
//        case signature
//        case _stripe_customer_id
//        case guard_ = "guard"
//        case _facebook_id
//        case timezone
//        case site_preferences
//        case occupation
//        case _image
//        case jabber_id
//        case languages
//        case _badges
//        case location
//        case external_service_password
//        case _principals
//        case _enrollments
//        case email
//        case website_url
//        case external_accounts
//        case bio
//        case coaching_data
//        case tags
//        case _affiliate_profiles
//        case email_preferences
//        case _resume
//        case employer_sharing
//        case _memberships
//        case zendesk_id
//        case _registered
//        case linkedin_url
//        case _google_id
        
    }
}
