//
//  AdBannerStruct.swift
//  WitsProject
//
//  Created by yeoh on 29/06/2024.
//

import Foundation

// MARK: - JSON
struct AdBannerStruct: Codable {
    let msgCode, msgContent: String
    let result: Result
    
    // MARK: - Result
    struct Result: Codable {
        let bannerList: [BannerList]
    }

    // MARK: - BannerList
    struct BannerList: Codable {
        let adSeqNo: Int
        let linkURL: String

        enum CodingKeys: String, CodingKey {
            case adSeqNo
            case linkURL = "linkUrl"
        }
    }
}


