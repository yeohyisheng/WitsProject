//
//  MainViewController.swift
//  WitsProject
//
//  Created by yeoh on 27/06/2024.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var navigationView: UIView!
    @IBOutlet var headView: UIView!
    @IBOutlet var menuView: UIView!
    @IBOutlet var favouriteView: UIView!
    @IBOutlet var adView: UIView!
    @IBOutlet var tabbarView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let menuList: [MenuStruct] = [MenuStruct(image: .menuTransfer, title: "Transfer"),
                                  MenuStruct(image: .menuScan, title: "QR pay scan"),
                                  MenuStruct(image: .menuPayment, title: "Payment"),
                                  MenuStruct(image: .menuQRcode, title: "My QR code"),
                                  MenuStruct(image: .menuUtility, title: "Utility"),
                                  MenuStruct(image: .menuTopUp, title: "Top up")]
    var allUSDAccount: [AllUsageAccountStruct] = []
    var allKHRAccount: [AllUsageAccountStruct] = []
    var favouriteStruct: [FavouriteStruct] = []
    var usageNotificationStructs: [UsageNotificationStruct] = []
    var refreshControl = UIRefreshControl()
    var isFirstOpen = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        initView()
        
        print("scrollView.contentSize = \(scrollView.contentSize)")
        print("scrollView.frame = \(scrollView.frame)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
//        initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        initView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setMenuView() {
        for view in menuView.subviews {
            let className = String(describing: type(of: view))
            if className == "MenuView" {
                print("reload")
                let subView = view as! MenuView
                subView.collectionView.reloadData()
            }
        }
    }

    func goToNotificationViewController() {
        let notificationViewController = NotificationViewController()
        notificationViewController.usageNotificationStructs = usageNotificationStructs
        navigationController?.pushViewController(notificationViewController, animated: true)
    }
    
    private func initView() {
        let nib = UINib(nibName: "NavigationView", bundle: nil)
        guard let navigationCustomView = nib.instantiate(withOwner: self, options: nil).first as? NavigationView else {
            return
        }
        navigationCustomView.frame = navigationView.bounds
        navigationView.addSubview(navigationCustomView)
        navigationCustomView.setData(bellImage: UIImage(resource: .bellNotActive))
        navigationCustomView.onTouchBell = goToNotificationViewController
        
        let headViewNib = UINib(nibName: "HeadView", bundle: nil)
        guard let headCustomView = headViewNib.instantiate(withOwner: self, options: nil).first as? HeadView else {
            return
        }
        headCustomView.frame = headView.bounds
        headView.addSubview(headCustomView)
        headCustomView.topMoneyLabel.showSkeleton()
        headCustomView.bottomMoneyLabel.showSkeleton()
        Task {
            if let allUSDAccount = await NetworkManager.shared.initUSDAllAccount(),
               let allKHRAccount = await NetworkManager.shared.initKHRAllAccount() {
                self.allUSDAccount = allUSDAccount
                self.allKHRAccount = allKHRAccount
                for i in 0 ..< allUSDAccount.count {
                    if allUSDAccount[i].type == .Saving {
                        headCustomView.currentUsageCurrencyStruct = allUSDAccount[i].usageCurrencyStructs
                    }
                }
                headCustomView.topMoneyLabel.hideSkeleton()
                headCustomView.bottomMoneyLabel.hideSkeleton()
            }

        }
        
        
        let menuViewNib = UINib(nibName: "MenuView", bundle: nil)
        guard let menuCustomView = menuViewNib.instantiate(withOwner: self, options: nil).first as? MenuView else {
            print("failed load menuView")
            return
        }
        menuCustomView.frame = menuView.bounds
        menuView.addSubview(menuCustomView)
        print("menuCustomView = \(menuCustomView.frame.height), menuCustomView.collectionViewHeight = \(menuCustomView.collectionView.frame.height)")
        
        let favouriteViewNib = UINib(nibName: "FavouriteView", bundle: nil)
        guard let favouriteCustomView = favouriteViewNib.instantiate(withOwner: self, options: nil).first as? FavouriteView else {
            print("failed load favouriteView")
            return
        }
        favouriteCustomView.frame = favouriteView.bounds
        favouriteView.addSubview(favouriteCustomView)
        
        let adViewNib = UINib(nibName: "ADView", bundle: nil)
        guard let adCustomView = adViewNib.instantiate(withOwner: self, options: nil).first as? ADView else {
            print("failed load adView")
            return
        }
        adCustomView.frame = adView.bounds
        adView.addSubview(adCustomView)
        
        let tabbarViewNib = UINib(nibName: "TabBarView", bundle: nil)
        guard let tabbarCustomView = tabbarViewNib.instantiate(withOwner: self, options: nil).first as? TabBarView else {
            print("failed load tabbarView")
            return
        }
        tabbarCustomView.frame = tabbarView.bounds
        tabbarView.addSubview(tabbarCustomView)
        tabbarCustomView.delegate = self
        tabbarCustomView.chooseUSD = {
            if self.isFirstOpen {
                headCustomView.mode = .USD
            }
        }
        tabbarCustomView.chooseKHR = {
            if self.isFirstOpen {
                headCustomView.mode = .KHR
            }
        }
        
        tabbarCustomView.chooseAccount = { (accountType: AccountType) in
            let isUSD = headCustomView.bottomCurrencyLabel.text == "USD"
            if isUSD {
                for i in 0 ..< self.allUSDAccount.count {
                    if self.allUSDAccount[i].type == accountType {
                        headCustomView.currentUsageCurrencyStruct = self.allUSDAccount[i].usageCurrencyStructs
                    }
                }
            } else {
                for i in 0 ..< self.allKHRAccount.count {
                    if self.allKHRAccount[i].type == accountType {
                        headCustomView.currentUsageCurrencyStruct = self.allKHRAccount[i].usageCurrencyStructs
                    }
                }
            }
            
            
        }
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    private func fetchData() {
        let headView = self.headView.subviews.filter{$0 is HeadView}.first as! HeadView
        headView.topMoneyLabel.showSkeleton()
        headView.bottomMoneyLabel.showSkeleton()
        Task {
            guard let notificationList = await NetworkManager.shared.fetchNotification(),
            let allUSDAccount = await NetworkManager.shared.refreshUSDAllAccount(),
            let allKHRAccount = await NetworkManager.shared.refreshKHRAllAccount(),
            let favouriteStruct = await NetworkManager.shared.fetchFavourite() else { return }
            self.usageNotificationStructs = notificationList
            self.allUSDAccount = allUSDAccount
            self.allKHRAccount = allKHRAccount
            self.favouriteStruct = favouriteStruct
            let navigationView = self.navigationView.subviews.filter{$0 is NavigationView}.first as! NavigationView
            navigationView.setData(bellImage: UIImage(resource: .bellActive))
            let headView = self.headView.subviews.filter{$0 is HeadView}.first as! HeadView
            for i in 0 ..< self.allUSDAccount.count {
                if self.allUSDAccount[i].type == .Saving {
                    headView.currentUsageCurrencyStruct = self.allUSDAccount[i].usageCurrencyStructs
                }
            }
            headView.topMoneyLabel.hideSkeleton()
            headView.bottomMoneyLabel.hideSkeleton()
            let favouriteView = self.favouriteView.subviews.filter{$0 is FavouriteView}.first as! FavouriteView
            favouriteView.favouriteList = favouriteStruct
            favouriteView.setCollectionView()
            print("allUSDAccount = \(self.allUSDAccount), allKHRAccount = \(self.allKHRAccount)")
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refresh() {
        fetchData()
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.cellIdentifier, for: indexPath) as! MenuCollectionViewCell
        cell.setData(title: menuList[indexPath.row].title, image: menuList[indexPath.row].image)
        
        return cell
    }
}

extension MainViewController: TabbarViewDelegate {
    func showAlertController(controller: UIAlertController) {
        print("showAlert")
        present(controller, animated: true) {
        }
    }
    
    
}
