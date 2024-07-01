//
//  SavingStruct.swift
//  WitsProject
//
//  Created by yeoh on 30/06/2024.
//

import Foundation

// MARK: - JSON
struct SavingStruct: Codable {
    let msgCode, msgContent: String
    let result: Result
    
    // MARK: - Result
    struct Result: Codable {
        let savingsList: [SavingsList]
    }

    // MARK: - SavingsList
    struct SavingsList: Codable {
        let account, curr: String
        let balance: Double
    }
}
