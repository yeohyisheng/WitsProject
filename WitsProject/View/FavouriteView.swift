//
//  FavouriteView.swift
//  WitsProject
//
//  Created by yeoh on 29/06/2024.
//

import UIKit

class FavouriteView: UIView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var moreView: UIView!
    @IBOutlet var arrowImageView: UIImageView!
    @IBOutlet var buttonTitleLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var emptyView: UIView!
    @IBOutlet var noNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var favouriteList: [FavouriteStruct] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func initView() {
        emptyView.isHidden = false
        collectionView.isHidden = true
        
        titleLabel.textColor = UIColor.rgb(red: 136, green: 136, blue: 136)
        buttonTitleLabel.textColor = UIColor.rgb(red: 85, green: 85, blue: 85)
        noNameLabel.textColor = UIColor.rgb(red: 111, green: 111, blue: 111)
        descriptionLabel.textColor = UIColor.rgb(red: 111, green: 111, blue: 111)
    }

    func setCollectionView() {
        emptyView.isHidden = true
        collectionView.isHidden = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let itemHeight = collectionView.bounds.height * (80 / 88)
        let itemWidth = collectionView.bounds.width * (80 / 375)
        collectionViewFlowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectionViewFlowLayout.estimatedItemSize = .zero
        collectionViewFlowLayout.minimumLineSpacing = .zero
        collectionViewFlowLayout.minimumInteritemSpacing = .zero
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        let favouriteCellNib = UINib(nibName: "FavouriteCollectionViewCell", bundle: nil)
        collectionView.register(favouriteCellNib, forCellWithReuseIdentifier: FavouriteCollectionViewCell.cellIdentifier)
    }
}

extension FavouriteView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCollectionViewCell.cellIdentifier, for: indexPath) as! FavouriteCollectionViewCell
        cell.setData(image: favouriteList[indexPath.row].image ?? UIImage(),
                     title: favouriteList[indexPath.row].title)
        return cell
    }
}
