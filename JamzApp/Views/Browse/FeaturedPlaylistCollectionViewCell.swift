//
//  FeaturedPlaylistCollectionViewCell.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .thin)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        creatorNameLabel.frame = CGRect()
        playlistNameLabel.frame = CGRect()
        playlistCoverImageView.frame = CGRect()
        creatorNameLabel.frame = CGRect(
            x: 3,
            y: contentView.frame.height-30,
            width: contentView.frame.width-6,
            height: 30)
        playlistNameLabel.frame = CGRect(
            x: 3,
            y: contentView.frame.height-60,
            width: contentView.frame.width-6,
            height: 30)
        let imageSize = contentView.frame.height-70

        playlistCoverImageView.frame = CGRect(
            x: (contentView.frame.width-imageSize)/2,
            y: 3,
            width: imageSize,
            height: imageSize)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func confgure(with viewModel: FeaturedPlaylistCellViewModel){
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}

    

