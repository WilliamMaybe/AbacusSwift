//
//  ContactUsViewController.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  联系我们主页

import UIKit
import SafariServices

private let cellIdentifier = "contactUs_cell"

class ContactUsViewController: BaseViewController {

    // MARK: - Variables
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.bounces    = false
        
        tableView.registerCellClass(ContactUsNormalCell)
        tableView.registerCellClass(ContactFollowTableViewCell)
        
        return tableView
    }()
    
    private let titles = [
        (CONTACTUS_TITLE_1(), CONTACTUS_CONTENT_1(), "ContactUs_phone"),
        (CONTACTUS_TITLE_2(), CONTACTUS_CONTENT_2(), "ContactUs_fax"),
        (CONTACTUS_TITLE_3(), CONTACTUS_CONTENT_3(), "ContactUs_email")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = CONTACTUS()
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        let footer = ContactUsFooter()
        tableView.tableFooterView = footer
        footer.snp_makeConstraints { (make) in
            make.top.equalTo(tableView).offset(45 * tableView(tableView, numberOfRowsInSection: 0))
            make.left.right.equalTo(view)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ContactUsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count + 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < titles.count {
            let cell = tableView.dequeueReusableCellClass(ContactUsNormalCell) as! ContactUsNormalCell
            
            cell.textLabel?.text = titles[indexPath.row].0
            cell.contentLabel.text = titles[indexPath.row].1
            cell.accessoryView = UIImageView(image: UIImage(named: titles[indexPath.row].2))
            
            switch indexPath.row {
            case 0:  cell.contentLabel.font = UIFont.font_hn_bold(15)
            default: cell.contentLabel.font = UIFont.font_hn_light(15)
            }
            
            return cell
        }
        
        // follow us
        if indexPath.row == titles.count {
            let cell = tableView.dequeueReusableCellClass(ContactFollowTableViewCell) as! ContactFollowTableViewCell
            
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - ContactFollowTableViewCellDelegate
extension ContactUsViewController: ContactFollowTableViewCellDelegate {
    func followClicked(type: ContactUsFollowType) {
        if type != .weixin {
            
            let safariController = SFSafariViewController(URL: type.url)
            presentViewController(safariController, animated: true, completion: nil)
            return
        }
        
        ContactQRAlertView .showOnView(tabBarController!.view)
    }
}
