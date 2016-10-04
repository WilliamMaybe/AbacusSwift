//
//  RepaymentViewController.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  贷款利息计算主页

import UIKit

private let cell_height = 45

class RepaymentViewController: BaseViewController {
    
    fileprivate let titleList = [REPAYMENT_TITLE_1(),
                             REPAYMENT_TITLE_2(),
                             REPAYMENT_TITLE_3(),
                             REPAYMENT_TITLE_4(),
                             REPAYMENT_TITLE_5(),]
    
    lazy var tableView = UITableView()
    lazy var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = REPAYMENT()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: RESET(), style: .plain, target: self, action: #selector(clickToReset))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(clickToMail))
        
        commonInit()
    }
    
    override func loadView() {
        view = UIScrollView()
    }
    
    fileprivate func commonInit() {
        tableView.bounces    = false
        tableView.delegate   = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.leading.width.equalTo(view)
            make.height.equalTo(cell_height * titleList.count)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    
}

extension RepaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cell_height)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let normalIdentifier = "normal"

        if (indexPath as NSIndexPath).row < 3 {
            var cell: TextFieldTableViewCell
            if let tmp = tableView.dequeueReusableCellClass(TextFieldTableViewCell.self) as! TextFieldTableViewCell? {
                cell = tmp
            } else {
                cell = TextFieldTableViewCell(style: .default, reuseIdentifier: String(describing: TextFieldTableViewCell.self))
                
            }
            
            cell.titleLabel.text = titleList[(indexPath as NSIndexPath).row]
            switch (indexPath as NSIndexPath).row {
            case 0:
                cell.mode = .money
            case 1:
                cell.mode = .term
            case 2:
                cell.mode = .rate
            default: break
            }
            
            cell.textFinished({ (output) in
                // TODO: switch
            })
            
            return cell
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: normalIdentifier) {
            
            cell.textLabel?.text = titleList[(indexPath as NSIndexPath).row]
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//            [cell.textLabel setText:[_arrayTitle objectAtIndex:indexPath.row]];
//            [cell.textLabel setTextColor:COLOR_THEME_GREEN];
//            [cell.detailTextLabel setTextColor:COLOR_THEME_GREEN];
//            [cell.detailTextLabel setFont:[UIFont fontWithName:FONT_HN_LIGHT size:15]];
//            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//            if (indexPath.row == 3)
//            {
//                [cell.detailTextLabel setText:[_arrayFrequency firstObject]];
//            }
//            else
//            {
//                [cell.detailTextLabel setText:[_arrayType firstObject]];
//                
//            }
            return cell
        }
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: normalIdentifier)
        cell.textLabel?.text = titleList[(indexPath as NSIndexPath).row]
        cell.textLabel?.textColor = UIColor.themeGreen()
        
        cell.detailTextLabel?.textColor = UIColor.themeGreen()
        cell.detailTextLabel?.font = UIFont.font_hn_light(15)
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}

// MARK: - Responses
extension RepaymentViewController {
    
    @objc fileprivate func clickToReset() {
        
    }
    
    @objc fileprivate func clickToMail() {
        
    }
}
