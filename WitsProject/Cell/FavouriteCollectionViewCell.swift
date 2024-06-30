//
//  FavouriteCollectionViewCell.swift
//  WitsProject
//
//  Created by yeoh on 29/06/2024.
//

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet var buttonView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    static let cellIdentifier = "FavouriteCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(image: UIImage, title: String) {
        imageView.image = image
        titleLabel.text = title
        titleLabel.textColor = UIColor.rgb(red: 111, green: 111, blue: 111)
    }
}
