//
//  NotificationStruct.swift
//  WitsProject
//
//  Created by yeoh on 29/06/2024.
//

import Foundation

// MARK: - NotificationStruct
struct NotificationStruct: Codable {
    let msgCode, msgContent: String
    let result: Result
    
    // MARK: - Result
    struct Result: Codable {
        let messages: [Message]
    }

    // MARK: - Message
    struct Message: Codable {
        let status: Bool
        let updateDateTime: String
        let title: String
        let message: String
    }
}


