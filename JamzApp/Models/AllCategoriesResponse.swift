//
//  AllCategoriesResponse.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
    
}
struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
    
}


