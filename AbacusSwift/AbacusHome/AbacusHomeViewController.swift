//
//  AbacusHomeViewController.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  home主页

import UIKit
import SnapKit

class AbacusHomeViewController: BaseViewController {

    private lazy var scrollView: UIScrollView     = {
        let lazyScrollView = UIScrollView()
        lazyScrollView.backgroundColor = UIColor.whiteColor()
        
        return lazyScrollView
    }()
    private lazy var headerImageView: UIImageView = { return UIImageView(image: UIImage(named: "home_header")) }()
    private lazy var tableView: UITableView = {
        let lazyTableView = UITableView(frame: CGRect.zero, style: .Grouped)
        lazyTableView.backgroundColor = UIColor.whiteColor()
        lazyTableView.bounces = false
        lazyTableView.delegate = self
        lazyTableView.dataSource = self
        return lazyTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: localStringFromKey(ABACUS_BUTTON_TEXT), style: .Plain, target: self, action: "clickToChangeLanguage")
        
        navigationItem.titleView = UIImageView(image: UIImage(named: localStringFromKey(HOMELOGO)))
        
        initComponents()
    }
    
    private func initComponents() {
        scrollView.backgroundColor = UIColor.whiteColor()
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(view)
            make.bottom.equalTo(snp_bottomLayoutGuideTop)
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(view)
            make.top.bottom.equalTo(scrollView)
        }

        contentView.addSubview(headerImageView)
        contentView.addSubview(tableView)
        
        headerImageView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(CGRectGetWidth(view.frame) * 631 / 640)
        }
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(headerImageView)
            make.top.equalTo(headerImageView.snp_bottom)
            make.bottom.equalTo(contentView)
            make.height.equalTo(70 + 90)
        }
    }

    // MARK: - Button Click
    @objc private func clickToChangeLanguage() {
        let alertVC = UIAlertController(title: localStringFromKey(REMIND), message: localStringFromKey(CONTENT), preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: localStringFromKey(CANCEL), style: .Cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: localStringFromKey(DONE), style: .Default, handler: { (action) -> Void in
            InternationalControl.changeLanguage()
            let delegate = UIApplication.sharedApplication().delegate
            delegate?.window??.rootViewController = TabBarController()
        }))
        
        presentViewController(alertVC, animated: true, completion: nil)
    }
}

// MARK: - UITableView Delegate & DataSource
extension AbacusHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 22, height: 45)))
        headerView.backgroundColor = UIColor.whiteColor()
        
        let headerLabel = UILabel()
        headerLabel.text = localStringFromKey(ABACUS_TITLE)
        headerLabel.font = UIFont.boldSystemFontOfSize(17)
        headerLabel.textColor = UIColor.themeGreen()
        headerLabel.textAlignment = .Center
        
        headerView.addSubview(headerLabel)
        headerLabel.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(headerView)
        }
        
        return headerView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            cell!.accessoryType = .DisclosureIndicator
            cell!.textLabel!.textColor = UIColor.themeGreen()
        }
        
        cell!.textLabel?.text = localStringFromKey((indexPath.row == 0 ? ABACUS_LOAN_TITLE_1 : ABACUS_LOAN_TITLE_2))
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let loanVC = AbacusHomeLoanTypeViewController(loanTypes:LoanTypes(rawValue: indexPath.row)!)
        loanVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(loanVC, animated: true)
    }
}
