//
//  UILabel.swift
//  WitsProject
//
//  Created by yeoh on 01/07/2024.
//

import Foundation
import UIKit

extension UILabel {
    private struct AssociatedKeys {
        static var skeletonView = "skeletonView"
    }
    
    private var skeletonView: SkeletonView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.skeletonView) as? SkeletonView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.skeletonView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showSkeleton() {
        if skeletonView == nil {
            let skeleton = SkeletonView(frame: self.bounds)
            skeletonView = skeleton
            addSubview(skeleton)
            bringSubviewToFront(skeleton)
        }
        skeletonView?.isHidden = false
    }
    
    func hideSkeleton() {
        skeletonView?.isHidden = true
    }
    
    func removeSkeleton() {
        skeletonView?.removeFromSuperview()
        skeletonView = nil
    }
}
