//
//  HeadView.swift
//  WitsProject
//
//  Created by yeoh on 28/06/2024.
//

import UIKit

enum currency {
    case USD
    case KHR
}

class HeadView: UIView {

    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var eyeView: UIView!
    @IBOutlet var eyeImageView: UIImageView!
    @IBOutlet var topCurrencyLabel: UILabel!
    @IBOutlet var topMoneyLabel: UILabel!
    @IBOutlet var bottomCurrencyLabel: UILabel!
    @IBOutlet var bottomMoneyLabel: UILabel!
    
    var mode = currency.USD {
        didSet {
            bottomCurrencyLabel.text = mode == .USD ? "USD" : "KHR"
        }
    }
    
    var currentUsageCurrencyStruct: [UsageCurrencyStruct] = [] {
        didSet {
            setCurrencyText()
        }
    }
    
//    var currentTopCurrency = "USD"
//    var currentTopBalance = "0"
//    var currentBottomCurrency = "USD"
//    var currentBottomBalance = "0"
    var isShow = true
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func initView() {
        balanceLabel.text = "My Account Balance"
        balanceLabel.textColor = UIColor.rgb(red: 136, green: 136, blue: 136)
        topCurrencyLabel.textColor = UIColor.rgb(red: 85, green: 85, blue: 85)
        topMoneyLabel.textColor = UIColor.rgb(red: 68, green: 68, blue: 68)
        bottomCurrencyLabel.textColor = UIColor.rgb(red: 85, green: 85, blue: 85)
        bottomMoneyLabel.textColor = UIColor.rgb(red: 68, green: 68, blue: 68)
        setCurrencyText()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showBalance))
        eyeView.addGestureRecognizer(tapGesture)
    }
    
    func setCurrencyText() {
        for i in 0 ..< currentUsageCurrencyStruct.count {
            if mode == .USD {
                if i == 0 {
                    topCurrencyLabel.text = currentUsageCurrencyStruct[i].currency
                    topMoneyLabel.text = currentUsageCurrencyStruct[i].balance
                } else {
                    bottomCurrencyLabel.text = currentUsageCurrencyStruct[i].currency
                    bottomMoneyLabel.text = currentUsageCurrencyStruct[i].balance
                }
            } else {
                if bottomCurrencyLabel.text == "KHR",
                   currentUsageCurrencyStruct[i].currency == bottomCurrencyLabel.text {
                    bottomCurrencyLabel.text = currentUsageCurrencyStruct[i].currency
                    bottomMoneyLabel.text = currentUsageCurrencyStruct[i].balance
                } else {
                    topCurrencyLabel.text = currentUsageCurrencyStruct[i].currency
                    topMoneyLabel.text = currentUsageCurrencyStruct[i].balance
                }
            }
        }
    }
    
    func setHideText() {
        topMoneyLabel.text = "********"
        bottomMoneyLabel.text = "********"
    }
    
    // eyeOnOff
    @objc func showBalance() {
        isShow = !isShow
        if isShow {
            setCurrencyText()
            eyeImageView.image = UIImage(resource: .eyeOn)
        }
        else {
            setHideText()
            eyeImageView.image = UIImage(resource: .eyeOff)
        }
        print("showBalance = \(isShow)")
    }
}
