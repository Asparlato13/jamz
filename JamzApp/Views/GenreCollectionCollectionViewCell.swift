//
//  GenreCollectionCollectionViewCell.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()
    
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    
    private let colors: [UIColor] = [
        .systemBlue,
        .systemPink,
        .systemPurple,
        .systemGreen,
        .systemOrange,
        .systemYellow,
        .systemRed,
        .systemTeal,
        .systemGray
        
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(imageView)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }
    override func layoutSubviews() {
        super.layoutSubviews()

       
   
        label.bounds.size
      //  view.bounds.size
        label.frame = CGRect(x: 10, y: contentView.frame.height/2, width: contentView.frame.width-20, height: contentView.frame.height/2)
        imageView.frame = CGRect(x: contentView.frame.width/2, y: 10, width: contentView.frame.width/2, height: contentView.frame.height/2)
    }

    func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        label.text = viewModel.title
        imageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
        contentView.backgroundColor = colors.randomElement()
    }
    
    
}

