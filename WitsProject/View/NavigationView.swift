//
//  NavigationView.swift
//  WitsProject
//
//  Created by yeoh on 27/06/2024.
//

import UIKit

class NavigationView: UIView {

    @IBOutlet var rightView: UIView!
    @IBOutlet var avatarView: UIImageView!
    @IBOutlet var bellView: UIImageView!
    
    var onTouchBell: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bellAction))
        rightView.addGestureRecognizer(tapGesture)
    }
        
    @objc func bellAction() {
        onTouchBell?()
    }
    
    private func initView() {
        avatarView.image = UIImage(resource: .avatar)
    }
    
    // on off
    func setData(bellImage: UIImage) {
        bellView.image = bellImage
    }
}
