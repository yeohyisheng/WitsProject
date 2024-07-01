//
//  TabBarView.swift
//  WitsProject
//
//  Created by yeoh on 30/06/2024.
//

import UIKit

protocol TabbarViewDelegate: NSObject {
    func showAlertController(controller: UIAlertController)
}

class TabBarView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let tabBarList: [TabBarStruct] = [TabBarStruct(image: .tabbarHomeActive, title: "Home"),
                                      TabBarStruct(image: .tabbarAccountDefault, title: "Account"),
                                      TabBarStruct(image: .tabbarLocationActive, title: "Location"),
                                      TabBarStruct(image: .tabbarPeople, title: "Service")]
    
    var delegate: TabbarViewDelegate?
    var chooseUSD: (() -> Void)?
    var chooseKHR: (() -> Void)?
    var chooseAccount: ((AccountType) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initView()
        setCollectionView()
    }
    
    private func initView() {
        layer.cornerRadius = bounds.width * (25 / 327)
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 8.0
        layer.shadowOffset = CGSize(width: 0, height: 4)
        
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let itemHeight = collectionView.bounds.height
        let itemWidth = collectionView.bounds.width * (70 / 295)
        collectionViewFlowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectionViewFlowLayout.estimatedItemSize = .zero
        collectionViewFlowLayout.minimumLineSpacing = .zero
        collectionViewFlowLayout.minimumInteritemSpacing = .zero
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        let favouriteCellNib = UINib(nibName: "TabBarCollectionViewCell", bundle: nil)
        collectionView.register(favouriteCellNib, forCellWithReuseIdentifier: TabBarCollectionViewCell.cellIdentifier)
    }
}

extension TabBarView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarCollectionViewCell.cellIdentifier, for: indexPath) as! TabBarCollectionViewCell
        if indexPath.row == 0 {
            cell.setData(title: tabBarList[indexPath.row].title, image: tabBarList[indexPath.row].image, textColor: UIColor.rgb(red: 255, green: 136, blue: 97))
            return cell
        }
        cell.setData(title: tabBarList[indexPath.row].title, image: tabBarList[indexPath.row].image, textColor: UIColor.rgb(red: 85, green: 85, blue: 85))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let controller = UIAlertController(title: "Choose currency", message: "", preferredStyle: .alert)
            let usdAction = UIAlertAction(title: "USD", style: .default) { _ in
                self.chooseUSD?()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let secondAlertController = UIAlertController(title: "Choose Account Type", message: "", preferredStyle: .actionSheet)
                    let names = [AccountType.Saving, AccountType.FixedDeposit, AccountType.Digital]
                    for name in names {
                        let action = UIAlertAction(title: name.toString(), style: .default) {_ in
                            self.chooseAccount?(name)
                        }
                        secondAlertController.addAction(action)
                    }
                    self.delegate?.showAlertController(controller: secondAlertController)
                }
            }
            controller.addAction(usdAction)
            let khrAction = UIAlertAction(title: "KHR", style: .default) { _ in
                self.chooseKHR?()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let secondAlertController = UIAlertController(title: "Choose Account Type", message: "", preferredStyle: .actionSheet)
                    let names = [AccountType.Saving, AccountType.FixedDeposit, AccountType.Digital]
                    for name in names {
                        let action = UIAlertAction(title: name.toString(), style: .default) {_ in
                            self.chooseAccount?(name)
                        }
                        secondAlertController.addAction(action)
                    }
                    self.delegate?.showAlertController(controller: secondAlertController)
                }
            }
            controller.addAction(khrAction)
            
            delegate?.showAlertController(controller: controller)
        }
    }
    
}
