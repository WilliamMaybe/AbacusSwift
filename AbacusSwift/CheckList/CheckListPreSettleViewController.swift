//
//  CheckListPreSettleViewController.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/2/28.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

private let titleKey    = "title"
private let describeKey = "describe"

class CheckListPreSettleViewController: UITableViewController {
    
    private lazy var sectionTitles =
    [
        localStringFromKey(CHECKLIST_PRESETTLE_TITLE_1),
        localStringFromKey(CHECKLIST_PRESETTLE_TITLE_2)
    ]
    
    private lazy var datas =
    [
        [
            titleKey : localStringFromKey(CHECKLIST_PRESETTLE_SUBTITLE_1),
            describeKey : localStringFromKey(CHECKLIST_PRESETTLE_SELECT_1)
        ],
        
        [
            titleKey : localStringFromKey(CHECKLIST_PRESETTLE_SUBTITLE_2),
            describeKey : localStringFromKey(CHECKLIST_PRESETTLE_SELECT_2)
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = localStringFromKey(CHECKLIST_TITLE_3)

        tableView.registerClass(CheckListHeaderView.self, forHeaderFooterViewReuseIdentifier: String(CheckListHeaderView))
        tableView.estimatedSectionHeaderHeight = 30
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}

// MARK: - UITableView datasource
extension CheckListPreSettleViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(CheckListPreTableViewCell)) as! CheckListPreTableViewCell
        
        cell.dataWithTitle(datas[indexPath.section][titleKey]!, describe: datas[indexPath.section][describeKey]!)
        
        return cell
    }
}

// MARK: - UITableView delegate
extension CheckListPreSettleViewController {
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(String(CheckListHeaderView)) as! CheckListHeaderView
        header.titleLabel.text = sectionTitles[section]
        return header
    }
}
