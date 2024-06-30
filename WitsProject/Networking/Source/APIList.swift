//
//  APIList.swift
//  WitsProject
//
//  Created by yeoh on 29/06/2024.
//

import Foundation
// Notification
private let emptyNotificationEndPoint = "https://willywu0201.github.io/data/emptyNotificationList.json"
private let notEmptyNotificationEndPoint = "https://willywu0201.github.io/data/notificationList.json"

// Account Balance
// init
private let initUSDSavingEndPoint = "https://willywu0201.github.io/data/usdSavings1.json"
private let initUSDFixedDepositEndPoint = "https://willywu0201.github.io/data/usdFixed1.json"
private let initUSDDigitalEndPoint = "https://willywu0201.github.io/data/usdDigital1.json"

private let initKHRSavingEndPoint = "https://willywu0201.github.io/data/khrSavings1.json"
private let initKHRFixedDepositEndPoint = "https://willywu0201.github.io/data/khrFixed1.json"
private let initKHRDigitalEndPoint = "https://willywu0201.github.io/data/khrDigital1.json"

// refresh
private let refreshUSDSavingEndPoint = "https://willywu0201.github.io/data/usdSavings2.json"
private let refreshUSDFixedDepositEndPoint = "https://willywu0201.github.io/data/usdFixed2.json"
private let refreshUSDDigitalEndPoint = "https://willywu0201.github.io/data/usdDigital2.json"

private let refreshKHRSavingEndPoint = "https://willywu0201.github.io/data/khrSavings2.json"
private let refreshKHRFixedDepositEndPoint = "https://willywu0201.github.io/data/khrFixed2.json"
private let refreshKHRDigitalEndPoint = "https://willywu0201.github.io/data/khrDigital2.json"

// Favourite List
private let emptyFavouriteEndPoint = "https://willywu0201.github.io/data/emptyFavoriteList.json"
private let notEmptyFavouriteEndPoint = "https://willywu0201.github.io/data/favoriteList.json"

// AD Banner
private let adBannerEndPoint = "https://willywu0201.github.io/data/banner.json"

enum APIList: String, Codable {
    case notification
    case usdSaving
    case usdDeposit
    case usdDigital
    case khrSaving
    case khrDeposit
    case khrDigital
    case favourite
    case adBanner
    
    func getInit() -> String {
        switch self {
        case .notification:
            return emptyNotificationEndPoint
        case .usdSaving:
            return initUSDSavingEndPoint
        case .usdDeposit:
            return initUSDFixedDepositEndPoint
        case .usdDigital:
            return initUSDDigitalEndPoint
        case .khrSaving:
            return initKHRSavingEndPoint
        case .khrDeposit:
            return initKHRFixedDepositEndPoint
        case .khrDigital:
            return initKHRDigitalEndPoint
        case .favourite:
            return emptyFavouriteEndPoint
        case .adBanner:
            return adBannerEndPoint
        }
    }

    func getRefresh() -> String {
        switch self {
        case .notification:
            return notEmptyNotificationEndPoint
        case .usdSaving:
            return refreshUSDSavingEndPoint
        case .usdDeposit:
            return refreshUSDFixedDepositEndPoint
        case .usdDigital:
            return refreshUSDDigitalEndPoint
        case .khrSaving:
            return refreshKHRSavingEndPoint
        case .khrDeposit:
            return refreshKHRFixedDepositEndPoint
        case .khrDigital:
            return refreshKHRDigitalEndPoint
        case .favourite:
            return notEmptyFavouriteEndPoint
        case .adBanner:
            return adBannerEndPoint
        }
    }

}

