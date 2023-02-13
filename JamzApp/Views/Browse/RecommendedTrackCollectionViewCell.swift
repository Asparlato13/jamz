//
//  RecommendedTrackCollectionViewCell.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    
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
  
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(TrackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
      
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.albumCoverImageView.frame = CGRect(
//            x: 5,
//            y: 2,
//            width: contentView.height-4,
//            height: contentView.height-4
        )
        artistNameLabel.frame =  CGRect(
//            x: albumCoverImageView.right+10,
//            y: contentView.height/2,
//            width: contentView.width-albumCoverImageView.right-15,
//            height: contentView.height/2
        )
//
        TrackNameLabel.frame = CGRect(
//            x: albumCoverImageView.right+10,
//            y: 0,
//            width: contentView.width-albumCoverImageView.right-15,
//            height: contentView.height/2
        )


     

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        TrackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func confgure(with viewModel: RecommendedTrackCellViewModel){
        TrackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}


