//
//  AlbumTrackCollectionViewCell.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import UIKit
import Foundation

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AlbumTrackCollectionViewCell"


    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .thin)
        return label
    }()

    private let TrackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(TrackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
      
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        artistNameLabel.frame =  CGRect(
            x: 10,
            y: contentView.height/2,
            width: contentView.width-15,
            height: contentView.height/2)
        
        TrackNameLabel.frame = CGRect(
            x: 10,
            y: 0,
            width: contentView.width-15,
            height: contentView.height/2)
       
        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        TrackNameLabel.text = nil
        artistNameLabel.text = nil
        
    }

    func confgure(with viewModel: AlbumCollectionViewCellViewModel){
        TrackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
       
    }
    }


