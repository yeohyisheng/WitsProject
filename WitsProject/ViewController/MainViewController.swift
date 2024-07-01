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
    private var allUSDAccount: [AllUsageAccountStruct] = []
    private var allKHRAccount: [AllUsageAccountStruct] = []
    private var favouriteStruct: [FavouriteStruct] = []
    private var usageNotificationStructs: [UsageNotificationStruct] = []
    private var headCustomView: HeadView?
    private var refreshControl = UIRefreshControl()
    private var isFirstOpen = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    private func goToNotificationViewController() {
        let notificationViewController = NotificationViewController()
        notificationViewController.usageNotificationStructs = usageNotificationStructs
        navigationController?.pushViewController(notificationViewController, animated: true)
    }
    
    private func initView() {
        initNavigationView()
        initHeadView()
        initMenuView()
        initFavouriteView()
        initADView()
        initTabbarView()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    private func initNavigationView() {
        let nib = UINib(nibName: "NavigationView", bundle: nil)
        guard let navigationCustomView = nib.instantiate(withOwner: self, options: nil).first as? NavigationView else {
            print("failed load navigationView")
            return
        }
        navigationCustomView.frame = navigationView.bounds
        navigationView.addSubview(navigationCustomView)
        navigationCustomView.setData(bellImage: UIImage(resource: .bellNotActive))
        navigationCustomView.onTouchBell = goToNotificationViewController

    }
    
    private func initHeadView() {
        let headViewNib = UINib(nibName: "HeadView", bundle: nil)
        guard let headCustomView = headViewNib.instantiate(withOwner: self, options: nil).first as? HeadView else {
            print("failed load headView")
            return
        }
        headCustomView.frame = headView.bounds
        headView.addSubview(headCustomView)
        self.headCustomView = headCustomView
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

    }
    
    private func initMenuView() {
        let menuViewNib = UINib(nibName: "MenuView", bundle: nil)
        guard let menuCustomView = menuViewNib.instantiate(withOwner: self, options: nil).first as? MenuView else {
            print("failed load menuView")
            return
        }
        menuCustomView.frame = menuView.bounds
        menuView.addSubview(menuCustomView)

    }
    
    private func initFavouriteView() {
        let favouriteViewNib = UINib(nibName: "FavouriteView", bundle: nil)
        guard let favouriteCustomView = favouriteViewNib.instantiate(withOwner: self, options: nil).first as? FavouriteView else {
            print("failed load favouriteView")
            return
        }
        favouriteCustomView.frame = favouriteView.bounds
        favouriteView.addSubview(favouriteCustomView)

    }
    
    private func initADView() {
        let adViewNib = UINib(nibName: "ADView", bundle: nil)
        guard let adCustomView = adViewNib.instantiate(withOwner: self, options: nil).first as? ADView else {
            print("failed load adView")
            return
        }
        adCustomView.frame = adView.bounds
        adView.addSubview(adCustomView)

    }
    
    private func initTabbarView() {
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
                self.headCustomView?.mode = .USD
            }
        }
        tabbarCustomView.chooseKHR = {
            if self.isFirstOpen {
                self.headCustomView?.mode = .KHR
            }
        }
        
        tabbarCustomView.chooseAccount = { (accountType: AccountType) in
            let isUSD = self.headCustomView?.bottomCurrencyLabel.text == "USD"
            if isUSD {
                for i in 0 ..< self.allUSDAccount.count {
                    if self.allUSDAccount[i].type == accountType {
                        self.headCustomView?.currentUsageCurrencyStruct = self.allUSDAccount[i].usageCurrencyStructs
                    }
                }
            } else {
                for i in 0 ..< self.allKHRAccount.count {
                    if self.allKHRAccount[i].type == accountType {
                        self.headCustomView?.currentUsageCurrencyStruct = self.allKHRAccount[i].usageCurrencyStructs
                    }
                }
            }
        }
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
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refresh() {
        fetchData()
    }
    
}

extension MainViewController: TabbarViewDelegate {
    func showAlertController(controller: UIAlertController) {
        present(controller, animated: true) {
        }
    }
    
    
}
