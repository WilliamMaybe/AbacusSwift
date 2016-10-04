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
    
    fileprivate lazy var sectionTitles =
    [
        CHECKLIST_PRESETTLE_TITLE_1(),
        CHECKLIST_PRESETTLE_TITLE_2()
    ]
    
    fileprivate lazy var datas =
    [
        [
            titleKey : CHECKLIST_PRESETTLE_SUBTITLE_1(),
            describeKey : CHECKLIST_PRESETTLE_SELECT_1()
        ],
        
        [
            titleKey : CHECKLIST_PRESETTLE_SUBTITLE_2(),
            describeKey : CHECKLIST_PRESETTLE_SELECT_2()
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = CHECKLIST_TITLE_3()

        tableView.register(CheckListHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: CheckListHeaderView.self))
        tableView.estimatedSectionHeaderHeight = 30
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}

// MARK: - UITableView datasource
extension CheckListPreSettleViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CheckListPreTableViewCell.self)) as! CheckListPreTableViewCell
        
        cell.dataWithTitle(datas[(indexPath as NSIndexPath).section][titleKey]!, describe: datas[(indexPath as NSIndexPath).section][describeKey]!)
        
        return cell
    }
}

// MARK: - UITableView delegate
extension CheckListPreSettleViewController {
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: CheckListHeaderView.self)) as! CheckListHeaderView
        header.titleLabel.text = sectionTitles[section]
        return header
    }
}
