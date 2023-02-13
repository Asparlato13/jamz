//
//  LibraryToggleView.swift
//
//
//  Created by Adrianna Parlato on 9/16/22.
//

import UIKit

//connect switching pages bsed on which button (album or playlist) thye click
protocol LibraryToggleViewDelegate: AnyObject {
    func LibraryToggleViewDidTapPlaylist(_ toggleView: LibraryToggleView)
    func LibraryToggleViewDidTapAlbum(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    enum State {
        case playlist
        case album
    }
    
    var state: State = .playlist
    
    weak var delegate: LibraryToggleViewDelegate?
    
    
    //set up playlist button for library  page
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    
    
    //set up album button for library  page
    
    private let albumButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()
    
    
    //set up signal for user to know which page they are on (album or playlist)
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // backgroundColor = .blue
        addSubview(playlistButton)
        addSubview(albumButton)
        addSubview(indicatorView)
        playlistButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        albumButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
    }
    
    
    required init(coder: NSCoder) {
        fatalError()
        
    }
    
    @objc private func didTapPlaylists() {
        state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.LibraryToggleViewDidTapPlaylist(self)
    }
    
    
    @objc private func didTapAlbums() {
        state = .album
        //animate green line
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.LibraryToggleViewDidTapAlbum(self)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 40)
        layoutIndicator()
        
        //set up layouttoggle  green line under playlist and ablum  between the pages based on which 'state'(aka page) the user clicks
        
        
    }
    func layoutIndicator() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom, width: 100, height: 3)
        case .album:
            indicatorView.frame = CGRect(x: 100, y: playlistButton.bottom, width: 100, height: 3)
        }
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        
    }
    
}
