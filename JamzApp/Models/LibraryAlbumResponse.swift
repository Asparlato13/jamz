//
//  LibraryAlbumResponse.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 2/13/23.
//

import Foundation
struct LibraryAlbumResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let album: Album
    let added_at: String
}
