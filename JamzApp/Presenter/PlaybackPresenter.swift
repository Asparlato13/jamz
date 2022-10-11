//
//  PlaybackPresenter.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import AVFoundation
import Foundation
import UIKit



//hook up getting name subtiitle text and image into controller

protocol PlayerDataSource: AnyObject {
    var songName: String? {get}
    var subtitle: String? {get}
    var imageURL: URL? {get}
}

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()

   
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    //hold onto reference of which track user is already playing
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        }
        else if let player = self.playerQueue, !tracks.isEmpty {
//            let item = player.currentItem
//            let items = player.items()
//            guard let index = items.firstIndex(where: { $0 == item }) else {
//                return nil
//            }
            return tracks[index]
        }
        return nil
    }
    
    var playerVC: PlayerViewController?
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
        
        //implenting url for previewing song
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        //plays preview of song
        player = AVPlayer(url: url)
        player?.volume = 0.5
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in self?.player?.play()
            
        }
        
        self.playerVC = vc
    }
    
    func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        self.tracks = tracks
        self.track = nil
        
        let items: [AVPlayerItem] = tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "") else {
                return nil
            }
            return AVPlayerItem(url: url)
        })
        
        
        self.playerQueue = AVQueuePlayer(items: items)
        
        self.playerQueue?.volume = 0.5
        self.playerQueue?.play()
        //when user hits green button this calls the presneter screen
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        self.playerVC = vc
    }
    
    
}

//hooking up functionality of buttons ( forward backwards and pause/play )
extension PlaybackPresenter: PlayerViewControllerDelegate {
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    func didTapNext() {
        if tracks.isEmpty {
            // not playlist or album
            player?.pause()
        }
        else if let player = playerQueue {
            player.advanceToNextItem()
            //update index
            index += 1
            //update cover image/artists name and song title when user clicks next
            playerVC?.refreshUI()
            
            
        }
        
    
    }
    func didTapBack() {
        if tracks.isEmpty {
            // not playlist or album
            player?.pause()
            player?.play()
        }
        else if let firstItem = playerQueue?.items().first{
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
            playerQueue?.volume = 0.5
            
        }
    }
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return  URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
    
}

