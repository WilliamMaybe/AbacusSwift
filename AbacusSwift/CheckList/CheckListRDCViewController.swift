//
//  CheckListRDCViewController.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/2/28.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

class CheckListRDCViewController: UITableViewController {

    @IBOutlet fileprivate weak var resetButtomItem: UIBarButtonItem!
    
    fileprivate let titleArray = [CHECKLIST_HOME_TITLE_1(),
                              CHECKLIST_HOME_TITLE_2(),
                              CHECKLIST_HOME_TITLE_3(),
                              CHECKLIST_HOME_TITLE_4(),
                              CHECKLIST_HOME_TITLE_5()]
    fileprivate let contentArray = [
        [
            CHECKLIST_HOME_SELECT_1_1(),
            CHECKLIST_HOME_SELECT_1_2(),
            CHECKLIST_HOME_SELECT_1_3(),
            CHECKLIST_HOME_SELECT_1_4(),
            CHECKLIST_HOME_SELECT_1_5(),
            CHECKLIST_HOME_SELECT_1_6()
        ],
        [
            CHECKLIST_HOME_SELECT_2_1(),
            CHECKLIST_HOME_SELECT_2_2(),
            CHECKLIST_HOME_SELECT_2_3(),
            CHECKLIST_HOME_SELECT_2_4()
        ],
        [
            CHECKLIST_HOME_SELECT_3_1(),
            CHECKLIST_HOME_SELECT_3_2(),
        ],
        [
            CHECKLIST_HOME_SELECT_4_1(),
            CHECKLIST_HOME_SELECT_4_2(),
            CHECKLIST_HOME_SELECT_4_3(),
        ],
        [
            CHECKLIST_HOME_SELECT_5_1(),
            CHECKLIST_HOME_SELECT_5_2(),
        ]
    ]
    
    fileprivate var selectedData = [Int]() {
        willSet {
            for index in selectedData {
                self.tableView.deselectRow(at: IndexPath(item: index % 10, section: index / 10), animated: false)
            }
        }
        
        didSet {
            for index in selectedData {
                self.tableView.selectRow(at: IndexPath(item: index % 10, section: index / 10), animated: false, scrollPosition: .none)
            }
            
        }
    }
    
    fileprivate let dataHandle = CheckListType.require
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title                 = CHECKLIST_TITLE_1()
        resetButtomItem.title = RESET()

        tableView.registerHeaderFooterViewClass(CheckListHeaderView.self)
        
        tableView.estimatedSectionHeaderHeight = 30
        tableView.sectionHeaderHeight          = UITableViewAutomaticDimension
        tableView.estimatedRowHeight           = 150
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.tableView.isEditing = true
            self.tableView.reloadData()
            self.selectedData = self.dataHandle.getData()!
        }
    }
    
    @IBAction func resetButtonItemClicked(_ sender: AnyObject) {
        selectedData = [Int]()
        dataHandle.resetData()
    }
}

// MARK: - UITableView Data Source
extension CheckListRDCViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CheckListRDCCell.self)) as! CheckListRDCCell
        
        cell.contentLabel.text = contentArray[indexPath.section][indexPath.row]
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension CheckListRDCViewController {
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: CheckListHeaderView.self)) as! CheckListHeaderView
        
        headerView.titleLabel.text = titleArray[section]
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedData.append(indexPath.row + indexPath.section * 10)
        dataHandle.addOrDeleteIdentifier(indexPath.row + indexPath.section * 10)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedData = selectedData.filter { $0 != indexPath.row + indexPath.section * 10 }
        dataHandle.addOrDeleteIdentifier(indexPath.row + indexPath.section * 10)
    }
}

class CheckListRDCCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
}
