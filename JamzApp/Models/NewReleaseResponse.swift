//
//  NewReleaseResponse.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import Foundation
struct NewReleasesResponses: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let id: String
    var images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
    
}
