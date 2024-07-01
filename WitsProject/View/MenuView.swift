//
//  MenuView.swift
//  WitsProject
//
//  Created by yeoh on 28/06/2024.
//

import UIKit

enum MenuAction: Int {
    case transfer
    case payment
    case utility
    case qrPayScan
    case myQRCode
    case topUp
    
}

class MenuView: UIView {
    @IBOutlet var collectionView: UICollectionView!
    let menuList: [MenuStruct] = [MenuStruct(image: .menuTransfer, title: "Transfer"),
                                  MenuStruct(image: .menuPayment, title: "Payment"),
                                  MenuStruct(image: .menuUtility, title: "Utility"),
                                  MenuStruct(image: .menuScan, title: "QR pay scan"),
                                  MenuStruct(image: .menuQRcode, title: "My QR code"),
                                  MenuStruct(image: .menuTopUp, title: "Top up")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        setCollectionView()
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = bounds
        collectionView.backgroundColor = .white
        let itemHeight: CGFloat = collectionView.bounds.height * (96 / 192)
        let itemWidth: CGFloat = collectionView.bounds.width * (125 / 375)
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectionViewFlowLayout.estimatedItemSize = .zero
        collectionViewFlowLayout.minimumLineSpacing = .zero
        collectionViewFlowLayout.minimumInteritemSpacing = .zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let menuCellNib = UINib(nibName: "MenuCollectionViewCell", bundle: nil)
            collectionView.register(menuCellNib, forCellWithReuseIdentifier: MenuCollectionViewCell.cellIdentifier)

    }
}

extension MenuView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.cellIdentifier, for: indexPath) as! MenuCollectionViewCell
        cell.setData(title: menuList[indexPath.row].title, image: menuList[indexPath.row].image)
        
        return cell
    }
}
