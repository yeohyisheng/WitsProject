//
//  MenuCollectionViewCell.swift
//  WitsProject
//
//  Created by yeoh on 28/06/2024.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet var buttonView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    static let cellIdentifier = "MenuCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setData(title: String, image: UIImage) {
        titleLabel.text = title
        titleLabel.textColor = UIColor.rgb(red: 85, green: 85, blue: 85)
        imageView.image = image
    }
}
