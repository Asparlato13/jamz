//
//  Playlist.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import Foundation

struct Playlist:  Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
