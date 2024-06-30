//
//  NetworkManager.swift
//  WitsProject
//
//  Created by yeoh on 30/06/2024.
//

import Foundation
class NetworkManager {
    
    static let shared = NetworkManager()
    
    func initUSDAllAccount() async -> [AllUsageAccountStruct]? {
        var allAccounts: [AllUsageAccountStruct] = []
        
        guard let savingAccount = await initUSDSaving(),
              let depositAccount = await initUSDDeposit(),
              let digitalAccount = await initUSDDigital()
        else { return nil }
        var savingAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .Saving)
        var depositAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .FixedDeposit)
        var digitalAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .Digital)
        savingAccounts.usageCurrencyStructs = savingAccount
        depositAccounts.usageCurrencyStructs = depositAccount
        digitalAccounts.usageCurrencyStructs = digitalAccount
        allAccounts.append(savingAccounts)
        allAccounts.append(depositAccounts)
        allAccounts.append(digitalAccounts)
        
        return allAccounts
    }
    
    func initKHRAllAccount() async -> [AllUsageAccountStruct]? {
        var allAccounts: [AllUsageAccountStruct] = []
        
        guard let savingAccount = await initKHRSaving(),
              let depositAccount = await initKHRDeposit(),
              let digitalAccount = await initKHRDigital()
        else { return nil }
        
        var savingAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .Saving)
        var depositAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .FixedDeposit)
        var digitalAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .Digital)
        savingAccounts.usageCurrencyStructs = savingAccount
        depositAccounts.usageCurrencyStructs = depositAccount
        digitalAccounts.usageCurrencyStructs = digitalAccount
        allAccounts.append(savingAccounts)
        allAccounts.append(depositAccounts)
        allAccounts.append(digitalAccounts)
        
        return allAccounts
    }
    
    func refreshUSDAllAccount() async -> [AllUsageAccountStruct]? {
        var allAccounts: [AllUsageAccountStruct] = []
        
        guard let savingAccount = await fetchUSDSaving(),
              let depositAccount = await fetchUSDDeposit(),
              let digitalAccount = await fetchUSDDigital()
        else { return nil }
        var savingAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .Saving)
        var depositAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .FixedDeposit)
        var digitalAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .Digital)
        savingAccounts.usageCurrencyStructs = savingAccount
        depositAccounts.usageCurrencyStructs = depositAccount
        digitalAccounts.usageCurrencyStructs = digitalAccount
        allAccounts.append(savingAccounts)
        allAccounts.append(depositAccounts)
        allAccounts.append(digitalAccounts)
        
        return allAccounts
    }
    
    func refreshKHRAllAccount() async -> [AllUsageAccountStruct]? {
        var allAccounts: [AllUsageAccountStruct] = []
        
        guard let savingAccount = await fetchKHRSaving(),
              let depositAccount = await fetchKHRDeposit(),
              let digitalAccount = await fetchKHRDigital()
        else { return nil }
        
        var savingAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .Saving)
        var depositAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .FixedDeposit)
        var digitalAccounts = AllUsageAccountStruct(usageCurrencyStructs: [], type: .Digital)
        savingAccounts.usageCurrencyStructs = savingAccount
        depositAccounts.usageCurrencyStructs = depositAccount
        digitalAccounts.usageCurrencyStructs = digitalAccount
        allAccounts.append(savingAccounts)
        allAccounts.append(depositAccounts)
        allAccounts.append(digitalAccounts)
        
        return allAccounts
    }
    
    
    func initNotification() -> UsageNotificationStruct? {
        let usageNotificationStruct = UsageNotificationStruct(status: false,
                                                              updateDateTime: "",
                                                              title: "",
                                                              message: "")
        Task {
            let notificationStruct = await NetworkController.shared.fetchEmptyNotification()
            guard let messages = notificationStruct?.result.messages else {
                return
            }
        }
        return usageNotificationStruct
    }
    
    func initUSDSaving() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchEmptyUSDSaving()
        guard let savingsList = usageCurrencyStruct?.result.savingsList else {
            return nil
        }
        
        for i in 0 ..< savingsList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = savingsList[i].curr
            usageCurrencyStruct.balance = String(savingsList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func initUSDDeposit() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchEmptyUSDFixedDeposit()
        guard let fixedDepositList = usageCurrencyStruct?.result.fixedDepositList else {
            return nil
        }
        
        for i in 0 ..< fixedDepositList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = fixedDepositList[i].curr
            usageCurrencyStruct.balance = String(fixedDepositList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func initUSDDigital() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchEmptyUSDDigital()
        guard let digitalList = usageCurrencyStruct?.result.digitalList else {
            return nil
        }
        
        for i in 0 ..< digitalList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = digitalList[i].curr
            usageCurrencyStruct.balance = String(digitalList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func initKHRSaving() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchEmptyKHRSaving()
        guard let savingsList = usageCurrencyStruct?.result.savingsList else {
            return nil
        }
        
        for i in 0 ..< savingsList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = savingsList[i].curr
            usageCurrencyStruct.balance = String(savingsList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func initKHRDeposit() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchEmptyKHRFixedDeposit()
        guard let fixedDepositList = usageCurrencyStruct?.result.fixedDepositList else {
            return nil
        }
        
        for i in 0 ..< fixedDepositList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = fixedDepositList[i].curr
            usageCurrencyStruct.balance = String(fixedDepositList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func initKHRDigital() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchEmptyKHRDigital()
        guard let digitalList = usageCurrencyStruct?.result.digitalList else {
            return nil
        }
        
        for i in 0 ..< digitalList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = digitalList[i].curr
            usageCurrencyStruct.balance = String(digitalList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func fetchUSDSaving() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchUSDSaving()
        guard let savingsList = usageCurrencyStruct?.result.savingsList else {
            return nil
        }
        
        for i in 0 ..< savingsList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = savingsList[i].curr
            usageCurrencyStruct.balance = String(savingsList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func fetchUSDDeposit() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchUSDFixedDeposit()
        guard let fixedDepositList = usageCurrencyStruct?.result.fixedDepositList else {
            return nil
        }
        
        for i in 0 ..< fixedDepositList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = fixedDepositList[i].curr
            usageCurrencyStruct.balance = String(fixedDepositList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func fetchUSDDigital() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchUSDDigital()
        guard let digitalList = usageCurrencyStruct?.result.digitalList else {
            return nil
        }
        
        for i in 0 ..< digitalList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = digitalList[i].curr
            usageCurrencyStruct.balance = String(digitalList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func fetchKHRSaving() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchKHRSaving()
        print("usageCurrencyStruct = \(usageCurrencyStruct)")
        guard let savingsList = usageCurrencyStruct?.result.savingsList else {
            return nil
        }
        
        for i in 0 ..< savingsList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = savingsList[i].curr
            usageCurrencyStruct.balance = String(savingsList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func fetchKHRDeposit() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchKHRFixedDeposit()
        guard let fixedDepositList = usageCurrencyStruct?.result.fixedDepositList else {
            return nil
        }
        
        for i in 0 ..< fixedDepositList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = fixedDepositList[i].curr
            usageCurrencyStruct.balance = String(fixedDepositList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func fetchKHRDigital() async -> [UsageCurrencyStruct]? {
        var usageCurrencyStructs: [UsageCurrencyStruct] = []
        
        let usageCurrencyStruct = await NetworkController.shared.fetchKHRDigital()
        guard let digitalList = usageCurrencyStruct?.result.digitalList else {
            return nil
        }
        
        for i in 0 ..< digitalList.count {
            var usageCurrencyStruct = UsageCurrencyStruct(currency: "",
                                                          balance: "")
            usageCurrencyStruct.currency = digitalList[i].curr
            usageCurrencyStruct.balance = String(digitalList[i].balance)
            usageCurrencyStructs.append(usageCurrencyStruct)
        }
        return usageCurrencyStructs
    }
    
    func fetchFavourite() async -> [FavouriteStruct]? {
        var favouriteStructs: [FavouriteStruct] = []
        
        let apiFavouriteStruct = await NetworkController.shared.fetchFavourite()
        guard let favoriteList = apiFavouriteStruct?.result.favoriteList else {
            return nil
        }
        
        for i in 0 ..< favoriteList.count {
            var favouriteStruct = FavouriteStruct(name: "",
                                                      rawValue: "")
            favouriteStruct.title = favoriteList[i].nickname
            favouriteStruct.image = FavouriteList(fromString: favoriteList[i].transType)?.toImage()
            favouriteStructs.append(favouriteStruct)
        }
        return favouriteStructs
    }
    
    // have data
    func fetchNotification() async -> [UsageNotificationStruct]? {
        var usageNotificationStructs: [UsageNotificationStruct] = []
        
        let notificationStruct = await NetworkController.shared.fetchNotification()
        print("notificationStruct = \(notificationStruct)")
        guard let messages = notificationStruct?.result.messages else {
            return nil
        }
        
        for i in 0 ..< messages.count {
            var usageNotificationStruct = UsageNotificationStruct(status: false,
                                                                  updateDateTime: "",
                                                                  title: "",
                                                                  message: "")
            usageNotificationStruct.status = messages[i].status
            usageNotificationStruct.title = messages[i].title
            usageNotificationStruct.updateDateTime = messages[i].updateDateTime
            usageNotificationStruct.message = messages[i].message
            usageNotificationStructs.append(usageNotificationStruct)
        }
        return usageNotificationStructs
    }
    
}
