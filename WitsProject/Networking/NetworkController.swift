//
//  NetworkController.swift
//  WitsProject
//
//  Created by yeoh on 28/06/2024.
//

import Foundation
import UIKit
class NetworkController: NSObject {
    static let shared = NetworkController()
}

extension NetworkController {
    // MARK: - fetchEmptyData
    func fetchEmptyNotification() async -> NotificationStruct? {
        var notificationStruct: NotificationStruct?
        let url = APIList.notification.getInit()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(NotificationStruct.self, from: data)
            notificationStruct = result
        }
        catch {
            print(error)
        }
        
        return notificationStruct
    }
    
    func fetchEmptyUSDSaving() async -> SavingStruct? {
        var savingStruct: SavingStruct?
        let url = APIList.usdSaving.getInit()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(SavingStruct.self, from: data)
            savingStruct = result
        }
        catch {
            print(error)
        }
        
        return savingStruct
    }
    
    func fetchEmptyUSDFixedDeposit() async -> FixedDepositStruct? {
        var fixedDepositStruct: FixedDepositStruct?
        let url = APIList.usdDeposit.getInit()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(FixedDepositStruct.self, from: data)
            fixedDepositStruct = result
        }
        catch {
            print(error)
        }
        
        return fixedDepositStruct
    }
    
    func fetchEmptyUSDDigital() async -> DigitalStruct? {
        var digitalStruct: DigitalStruct?
        let url = APIList.usdDigital.getInit()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(DigitalStruct.self, from: data)
            digitalStruct = result
        }
        catch {
            print(error)
        }
        
        return digitalStruct
    }
    
    func fetchEmptyKHRSaving() async -> SavingStruct? {
        var savingStruct: SavingStruct?
        let url = APIList.khrSaving.getInit()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(SavingStruct.self, from: data)
            savingStruct = result
        }
        catch {
            print(error)
        }
        
        return savingStruct
    }
    
    func fetchEmptyKHRFixedDeposit() async -> FixedDepositStruct? {
        var fixedDepositStruct: FixedDepositStruct?
        let url = APIList.khrDeposit.getInit()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(FixedDepositStruct.self, from: data)
            fixedDepositStruct = result
        }
        catch {
            print(error)
        }
        
        return fixedDepositStruct
    }
    
    func fetchEmptyKHRDigital() async -> DigitalStruct? {
        var digitalStruct: DigitalStruct?
        let url = APIList.khrDigital.getInit()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(DigitalStruct.self, from: data)
            digitalStruct = result
        }
        catch {
            print(error)
        }
        
        return digitalStruct
    }
    
    func fetchEmptyFavourite() async -> APIFavouriteStruct? {
        var apiFavouriteStruct: APIFavouriteStruct?
        let url = APIList.favourite.getInit()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(APIFavouriteStruct.self, from: data)
            apiFavouriteStruct = result
        }
        catch {
            print(error)
        }
        
        return apiFavouriteStruct
    }
    
    // MARK: - fetchData
    
    func fetchNotification() async -> NotificationStruct? {
        var notificationStruct: NotificationStruct?
        let url = APIList.notification.getRefresh()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(NotificationStruct.self, from: data)
            notificationStruct = result
        }
        catch {
            print(error)
        }
        
        return notificationStruct
    }
    
    func fetchUSDSaving() async -> SavingStruct? {
        var savingStruct: SavingStruct?
        let url = APIList.usdSaving.getRefresh()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(SavingStruct.self, from: data)
            savingStruct = result
        }
        catch {
            print(error)
        }
        
        return savingStruct
    }
    
    func fetchUSDFixedDeposit() async -> FixedDepositStruct? {
        var fixedDepositStruct: FixedDepositStruct?
        let url = APIList.usdDeposit.getRefresh()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(FixedDepositStruct.self, from: data)
            fixedDepositStruct = result
        }
        catch {
            print(error)
        }
        
        return fixedDepositStruct
    }
    
    func fetchUSDDigital() async -> DigitalStruct? {
        var digitalStruct: DigitalStruct?
        let url = APIList.usdDigital.getRefresh()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(DigitalStruct.self, from: data)
            digitalStruct = result
        }
        catch {
            print(error)
        }
        
        return digitalStruct
    }
    
    func fetchKHRSaving() async -> SavingStruct? {
        var savingStruct: SavingStruct?
        let url = APIList.khrSaving.getRefresh()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(SavingStruct.self, from: data)
            savingStruct = result
        }
        catch {
            print(error)
        }
        
        return savingStruct
    }
    
    func fetchKHRFixedDeposit() async -> FixedDepositStruct? {
        var fixedDepositStruct: FixedDepositStruct?
        let url = APIList.khrDeposit.getRefresh()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(FixedDepositStruct.self, from: data)
            fixedDepositStruct = result
        }
        catch {
            print(error)
        }
        
        return fixedDepositStruct
    }
    
    func fetchKHRDigital() async -> DigitalStruct? {
        var digitalStruct: DigitalStruct?
        let url = APIList.khrDigital.getRefresh()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(DigitalStruct.self, from: data)
            digitalStruct = result
        }
        catch {
            print(error)
        }
        
        return digitalStruct
    }
    
    func fetchFavourite() async -> APIFavouriteStruct? {
        var apiFavouriteStruct: APIFavouriteStruct?
        let url = APIList.favourite.getRefresh()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(APIFavouriteStruct.self, from: data)
            apiFavouriteStruct = result
        }
        catch {
            print(error)
        }
        
        return apiFavouriteStruct
    }
    
    func fetchBanner() async -> AdBannerStruct? {
        var adBannerStruct: AdBannerStruct?
        let url = APIList.adBanner.getInit()
        do {
            let data = try await fetchData(_: url)
            guard let data = data else {
                print("data is nil.")
                return nil
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(AdBannerStruct.self, from: data)
            adBannerStruct = result
        }
        catch {
            print(error)
        }
        
        return adBannerStruct
    }
    
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    private func fetchData(_ endPoint: String) async throws -> Data? {
        guard let url = URL(string: endPoint) else {
            print("fetch error")
            return nil
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("response is not 200, response  = \(response)")
            return nil
        }
        
        return data
    }
}
