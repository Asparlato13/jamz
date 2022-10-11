//
//  AuthResponse.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import Foundation
struct AuthResponse: Codable  {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
    
    
    
}
