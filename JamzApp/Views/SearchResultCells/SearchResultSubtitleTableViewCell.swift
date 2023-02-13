//
//  SearchResultSubtitleTableViewCell.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import UIKit
import SDWebImage

class SearchResultSubtitleTableViewCell: UITableViewCell {
    static let identifier = "SearchResultSubtitleTableViewCell"
    
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
        
    }()
    
    private let subtitlelabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
        
    }()
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(subtitlelabel)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }

    
    required override init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize : CGFloat = contentView.frame.height
        iconImageView.frame = CGRect(x: 10, y: 5, width: imageSize, height: imageSize)
        iconImageView.layer.cornerRadius = imageSize/2
        iconImageView.layer.masksToBounds = true
        let labelHeight = contentView.frame.height/2
        label.frame = CGRect(x: iconImageView.frame.maxX, y: 0, width: contentView.frame.width-iconImageView.frame.maxX, height: labelHeight)
        subtitlelabel.frame = CGRect(x: iconImageView.frame.maxX+10, y: labelHeight, width: contentView.frame.width-iconImageView.frame.maxX-15, height: labelHeight)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        subtitlelabel.text = nil
    }
    
    
    
    
    func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
        label.text = viewModel.title
        subtitlelabel.text = viewModel.subtitle
        iconImageView.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
    }
    
}

