//
//  PlayerViewController.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import UIKit
import SDWebImage


protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapNext()
    func didTapBack()
    func didSlideSlider(_ value: Float)
}


class PlayerViewController: UIViewController {
    
    
    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?


    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    private let controlsView = PlayerControlsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        controlsView.delegate = self
        configureBarButtons()
        
        configure()
        
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        imageView.frame = CGRect(
//            x: 0,
//            y: view.safeAreaInsets.top,
//            width: view.frame.width,
//            height: view.frame.width)
//        controlsView.frame = CGRect(
//            x: 10, y: imageView.bottom+10,
//            width: view.width-20,
//            height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
//       
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        view.bringSubviewToFront(imageView)
//        view.bringSubviewToFront(controlsView)
//    }
    
    //takes datasoruce and confir\gures ui components
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
       //adds song name and artist
        controlsView.configure(
            with: PlayerControlsViewModel(
            title: dataSource?.songName,
            subtitle: dataSource?.subtitle))
    }
    
    //buttons for closing presenting page in  top right corner
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        
        //button for potiental options -- sharing, add to playlist  etc
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
                                                           
    @objc private func didTapAction() {
            //actions
        }
    func refreshUI() {
        configure()
    }
                                                               
}


extension PlayerViewController: playerControlsViewDelegate {
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapPlayPause()
        
    }
    
    func playerControlsViewDidTapNextButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapNext()
    }
    
    func playerControlsViewDidTapBackButton(_ playeblrControlsView: PlayerControlsView) {
        delegate?.didTapBack()
    }
    
    
}
