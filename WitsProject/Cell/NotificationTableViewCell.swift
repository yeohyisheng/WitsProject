//
//  NotificationTableViewCell.swift
//  WitsProject
//
//  Created by yeoh on 30/06/2024.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    static let cellIdentifier = "NotificationTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(_ title: String, date: String, description: String) {
        titleLabel.text = title
        dateLabel.text = date
        descriptionLabel.text = description
        titleLabel.textColor = UIColor.rgb(red: 26, green: 26, blue: 26)
        dateLabel.textColor = UIColor.rgb(red: 26, green: 26, blue: 26)
        descriptionLabel.textColor = UIColor.rgb(red: 115, green: 116, blue: 126)
    }
    
    func setDot() {
        let dot = CAShapeLayer()
        let path = UIBezierPath(arcCenter: CGPoint(x: -10,
                                                   y: 10),
                                radius: bounds.width * (6 / 375),
                                startAngle: 0,
                                endAngle: .pi * 2,
                                clockwise: true)
        dot.path = path.cgPath
        dot.fillColor = UIColor.rgb(red: 255, green: 136, blue: 97).cgColor
        titleLabel.layer.addSublayer(dot)
    }
    
}
