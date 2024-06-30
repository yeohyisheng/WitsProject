//
//  NotificationViewController.swift
//  WitsProject
//
//  Created by yeoh on 30/06/2024.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet var arrowView: UIView!
    @IBOutlet var arrowImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var usageNotificationStructs: [UsageNotificationStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        titleLabel.textColor = UIColor.rgb(red: 26, green: 26, blue: 26)
        tableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: NotificationTableViewCell.cellIdentifier)
        tableView.separatorStyle = .none
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goBack))
        arrowView.addGestureRecognizer(tapGesture)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usageNotificationStructs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.cellIdentifier, for: indexPath) as! NotificationTableViewCell
        cell.setData(usageNotificationStructs[indexPath.row].title,
                     date: usageNotificationStructs[indexPath.row].updateDateTime,
                     description: usageNotificationStructs[indexPath.row].message)
        if usageNotificationStructs[indexPath.row].status == true {
            cell.setDot()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}
