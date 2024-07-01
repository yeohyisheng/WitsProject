//
//  ADView.swift
//  WitsProject
//
//  Created by yeoh on 29/06/2024.
//

import UIKit

class ADView: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private let maxShowDots = 3
    private var currentPage = 0
    private var bannerImage: [UIImage] = []
    private var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
        initImageView()
        checkNeedShowDots()
        startTimer()
    }
    
    private func initView() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    private func initImageView() {
        let networkController = NetworkController.shared
        Task {
            let adBannerStruct = await networkController.fetchBanner()
            let bannerList = adBannerStruct?.result.bannerList
            var images: [UIImage] = []
            
            guard let bannerList = bannerList else { return }
            scrollView.contentSize = CGSize(width: frame.width * CGFloat(bannerList.count), height: scrollView.frame.height)
            let dispatchGroup = DispatchGroup()
            for i in 0 ..< bannerList.count {
                dispatchGroup.enter()
                guard let url = URL(string: bannerList[i].linkURL) else { return }
                networkController.fetchImage(from: url) { image in
                    images.append(image ?? UIImage())
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) {
                for i in 0 ..< images.count {
                    let imageView = UIImageView()
                    let x = self.frame.width * (24 / 375)
                    imageView.frame = CGRect(x: self.frame.width * CGFloat(i) + x,
                                             y: 0,
                                             width: self.frame.width * (327 / 375),
                                             height: self.scrollView.frame.height)
                    imageView.image = images[i]
                    self.bannerImage.append(images[i])
                    self.scrollView.addSubview(imageView)
                }
                self.pageControl.numberOfPages = self.maxShowDots
                self.pageControl.currentPage = self.currentPage
            }
        }
    }
    
    private func startTimer() {
        DispatchQueue.main.async {
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 3,
                                                  target: self,
                                                  selector: #selector(self.autoScroll),
                                                  userInfo: nil,
                                                  repeats: true)
            }
        }
    }
    
    private func stopTimer() {
        DispatchQueue.main.async {
                    self.timer?.invalidate()
                    self.timer = nil
                }
    }
    
    private func changePage() {
        var nextPage = 0
        if currentPage < bannerImage.count - 1 {
            nextPage = currentPage + 1
        }
        DispatchQueue.main.async {
            self.scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.width * CGFloat(nextPage), y: 0), animated: true)
        }
        currentPage = nextPage
        checkNeedShowDots()
    }
        
    private func checkNeedShowDots() {
        pageControl.currentPage = currentPage > maxShowDots ? maxShowDots - 1 : currentPage
    }
    
    @objc private func autoScroll() {
        changePage()
    }
}

extension ADView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / frame.width)
        self.currentPage = currentPage
        checkNeedShowDots()
        startTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            startTimer()
        }
    }
}
