//
//  CheckListRDCViewController.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/2/28.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

class CheckListRDCViewController: UITableViewController {

    @IBOutlet private weak var resetButtomItem: UIBarButtonItem!
    
    private let titleArray = [localStringFromKey(CHECKLIST_HOME_TITLE_1),
                              localStringFromKey(CHECKLIST_HOME_TITLE_2),
                              localStringFromKey(CHECKLIST_HOME_TITLE_3),
                              localStringFromKey(CHECKLIST_HOME_TITLE_4),
                              localStringFromKey(CHECKLIST_HOME_TITLE_5)]
    private let contentArray = [
        [
            localStringFromKey(CHECKLIST_HOME_SELECT_1_1),
            localStringFromKey(CHECKLIST_HOME_SELECT_1_2),
            localStringFromKey(CHECKLIST_HOME_SELECT_1_3),
            localStringFromKey(CHECKLIST_HOME_SELECT_1_4),
            localStringFromKey(CHECKLIST_HOME_SELECT_1_5),
            localStringFromKey(CHECKLIST_HOME_SELECT_1_6)
        ],
        [
            localStringFromKey(CHECKLIST_HOME_SELECT_2_1),
            localStringFromKey(CHECKLIST_HOME_SELECT_2_2),
            localStringFromKey(CHECKLIST_HOME_SELECT_2_3),
            localStringFromKey(CHECKLIST_HOME_SELECT_2_4)
        ],
        [
            localStringFromKey(CHECKLIST_HOME_SELECT_3_1),
            localStringFromKey(CHECKLIST_HOME_SELECT_3_2),
        ],
        [
            localStringFromKey(CHECKLIST_HOME_SELECT_4_1),
            localStringFromKey(CHECKLIST_HOME_SELECT_4_2),
            localStringFromKey(CHECKLIST_HOME_SELECT_4_3),
        ],
        [
            localStringFromKey(CHECKLIST_HOME_SELECT_5_1),
            localStringFromKey(CHECKLIST_HOME_SELECT_5_2),
        ]
    ]
    
    private var selectedData = [Int]() {
        willSet {
            for index in selectedData {
                self.tableView.deselectRowAtIndexPath(NSIndexPath(forItem: index % 10, inSection: index / 10), animated: false)
            }
        }
        
        didSet {
            for index in selectedData {
                self.tableView.selectRowAtIndexPath(NSIndexPath(forItem: index % 10, inSection: index / 10), animated: false, scrollPosition: .None)
            }
            
        }
    }
    
    private let dataHandle = CheckListType.Require
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = localStringFromKey(CHECKLIST_TITLE_1)
        resetButtomItem.title = localStringFromKey(RESET)

        tableView.registerHeaderFooterViewClass(CheckListHeaderView.self)
        
        tableView.estimatedSectionHeaderHeight = 30
        tableView.sectionHeaderHeight          = UITableViewAutomaticDimension
        tableView.estimatedRowHeight           = 150
        
        dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue()) {
            self.tableView.editing = true
            self.tableView.reloadData()
            self.selectedData = self.dataHandle.getData()!
        }
    }
    
    @IBAction func resetButtonItemClicked(sender: AnyObject) {
        selectedData = [Int]()
        dataHandle.resetData()
    }
}

// MARK: - UITableView Data Source
extension CheckListRDCViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return titleArray.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(CheckListRDCCell)) as! CheckListRDCCell
        
        cell.contentLabel.text = contentArray[indexPath.section][indexPath.row]
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension CheckListRDCViewController {
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(String(CheckListHeaderView)) as! CheckListHeaderView
        
        headerView.titleLabel.text = titleArray[section]
        
        return headerView
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedData.append(indexPath.row + indexPath.section * 10)
        dataHandle.addOrDeleteIdentifier(indexPath.row + indexPath.section * 10)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        selectedData = selectedData.filter { $0 != indexPath.row + indexPath.section * 10 }
        dataHandle.addOrDeleteIdentifier(indexPath.row + indexPath.section * 10)
    }
}

class CheckListRDCCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
}