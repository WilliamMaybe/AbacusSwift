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

    fileprivate lazy var scrollView: UIScrollView     = {
        let lazyScrollView = UIScrollView()
        lazyScrollView.backgroundColor = UIColor.white
        
        return lazyScrollView
    }()
    fileprivate lazy var headerImageView: UIImageView = { return UIImageView(image: UIImage(named: "home_header")) }()
    fileprivate lazy var tableView: UITableView = {
        let lazyTableView = UITableView(frame: CGRect.zero, style: .grouped)
        lazyTableView.backgroundColor = UIColor.white
        lazyTableView.bounces = false
        lazyTableView.delegate = self
        lazyTableView.dataSource = self
        return lazyTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: ABACUS_BUTTON_TEXT(), style: .plain, target: self, action: #selector(AbacusHomeViewController.clickToChangeLanguage))
        
        navigationItem.titleView = UIImageView(image: UIImage(named: HOMELOGO()))
        
        initComponents()
    }
    
    fileprivate func initComponents() {
        scrollView.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(view)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(view)
            make.top.bottom.equalTo(scrollView)
        }

        contentView.addSubview(headerImageView)
        contentView.addSubview(tableView)
        
        headerImageView.snp.makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(view.frame.width * 631 / 640)
        }
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(headerImageView)
            make.top.equalTo(headerImageView.snp.bottom)
            make.bottom.equalTo(contentView)
            make.height.equalTo(70 + 90)
        }
    }

    // MARK: - Button Click
    @objc fileprivate func clickToChangeLanguage() {
        let alertVC = UIAlertController(title: REMIND(), message: CONTENT(), preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: CANCEL(), style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: DONE(), style: .default, handler: { (action) -> Void in
            InternationalControl.changeLanguage()
            let delegate = UIApplication.shared.delegate
            delegate?.window??.rootViewController = TabBarController()
        }))
        
        present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - UITableView Delegate & DataSource
extension AbacusHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 22, height: 45)))
        headerView.backgroundColor = UIColor.white
        
        let headerLabel = UILabel()
        headerLabel.text = ABACUS_TITLE()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 17)
        headerLabel.textColor = UIColor.themeGreen()
        headerLabel.textAlignment = .center
        
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(headerView)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            cell!.accessoryType = .disclosureIndicator
            cell!.textLabel!.textColor = UIColor.themeGreen()
        }
        
        cell!.textLabel?.text = (indexPath as NSIndexPath).row == 0 ? ABACUS_LOAN_TITLE_1() : ABACUS_LOAN_TITLE_2()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let loanVC = AbacusHomeLoanTypeViewController(loanTypes:LoanTypes(rawValue: (indexPath as NSIndexPath).row)!)
        loanVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(loanVC, animated: true)
    }
}
