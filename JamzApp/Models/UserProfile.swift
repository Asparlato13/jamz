//
//  UserProfile.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let product: String
    let images: [APIImage]

    
}
