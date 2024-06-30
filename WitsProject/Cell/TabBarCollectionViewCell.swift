//
//  TabBarCollectionViewCell.swift
//  WitsProject
//
//  Created by yeoh on 30/06/2024.
//

import UIKit

class TabBarCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    static let cellIdentifier = "TabBarCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setData(title: String, image: UIImage, textColor: UIColor) {
        titleLabel.text = title
        titleLabel.textColor = textColor
        imageView.image = image
    }

}
