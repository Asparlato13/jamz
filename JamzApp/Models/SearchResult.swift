//
//  SearchResult.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import Foundation

enum SearchResult {
    case artists(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
