//
//  UsageCurrencyStruct.swift
//  WitsProject
//
//  Created by yeoh on 30/06/2024.
//

import Foundation
enum AccountType {
    case Saving
    case FixedDeposit
    case Digital
    
    func toString() -> String {
            switch self {
            case .Saving:
                return "Saving"
            case .FixedDeposit:
                return "Fixed Deposit"
            case .Digital:
                return "Digital"
            }
        }
}

//typealias AllUsageAccountStruct = [[UsageCurrencyStruct]]
struct AllUsageAccountStruct {
    var usageCurrencyStructs: [UsageCurrencyStruct]
    var type: AccountType
}

struct UsageCurrencyStruct {
    var currency: String
    var balance: String
}
