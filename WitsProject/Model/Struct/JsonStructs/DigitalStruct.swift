//
//  DigitalStruct.swift
//  WitsProject
//
//  Created by yeoh on 30/06/2024.
//

import Foundation

// MARK: - JSON
struct DigitalStruct: Codable {
    let msgCode, msgContent: String
    let result: Result
    
    // MARK: - Result
    struct Result: Codable {
        let digitalList: [DigitalList]
    }

    // MARK: - DigitalList
    struct DigitalList: Codable {
        let account, curr: String
        let balance: Double
    }
}
