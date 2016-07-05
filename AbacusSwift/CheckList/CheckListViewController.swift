//
//  CheckListViewController.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  统计单主页

import UIKit

class CheckListViewController: UITableViewController {
    
    private let titleArray = [
        localStringFromKey(CHECKLIST_TITLE_1),
        localStringFromKey(CHECKLIST_TITLE_2),
        localStringFromKey(CHECKLIST_TITLE_3)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = localStringFromKey(CHECKLIST)
    }
}

extension CheckListViewController {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        cell.textLabel?.text = titleArray[indexPath.item]
        
        return cell
    }
}