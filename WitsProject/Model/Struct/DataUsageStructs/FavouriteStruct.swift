//
//  FavouriteStruct.swift
//  WitsProject
//
//  Created by yeoh on 29/06/2024.
//

import Foundation
import UIKit

enum FavouriteList {
    case CUBC
    case Mobile
    case PMF
    case CreditCard
    
    func toImage() -> UIImage {
        switch self {
        case .CUBC: return UIImage(resource: .scrollTree)
        case .Mobile: return UIImage(resource: .scrollMobile)
        case .PMF: return UIImage(resource: .scrollBuilding)
        case .CreditCard: return UIImage(resource: .scrollCreditCard)
        }
    }
    
    init?(fromString string: String) {
        switch string {
        case "CUBC":
            self = .CUBC
        case "Mobile":
            self = .Mobile
        case "PMF":
            self = .PMF
        case "CreditCard":
            self = .CreditCard
        default:
            return nil
        }
    }
}

struct FavouriteStruct {
    var image: UIImage?
    var title: String
    
    init(name: String, rawValue: String) {
        image = FavouriteList(fromString: rawValue)?.toImage()
        title = name
    }
}
