//
//  FixedDepositStruct.swift
//  WitsProject
//
//  Created by yeoh on 30/06/2024.
//

import Foundation

// MARK: - JSON
struct FixedDepositStruct: Codable {
    let msgCode, msgContent: String
    let result: Result
    
    // MARK: - Result
    struct Result: Codable {
        let fixedDepositList: [FixedDepositList]
    }

    // MARK: - FixedDepositList
    struct FixedDepositList: Codable {
        let account, curr: String
        let balance: Double
    }
}
