//
//  CheckListMovingViewController.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/2/28.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

/**
 *  一个提供enum存储变量的protocol
 */
private protocol CheckListMovingMessage {
    var message: String { get }
}

/**
 moving内cell的模式
 
 - Title:  标题模式
 - Select: 选择模式
 */
private enum CheckListMovingContentMode: CheckListMovingMessage {
    case Title(String)
    case Select(String)
    
    var message: String {
        get {
            switch self {
            case let .Select(string): return string
            case let .Title(string):  return string
            }
        }
    }
    
    func selectable() -> Bool {
        if case .Select(_) = self {
            return true
        }
        return false
    }
}

class CheckListMovingViewController: UITableViewController {
    
    @IBOutlet weak var resetButtonItem: UIBarButtonItem!
    
    // MARK: - Variables
    private let titleArray = [
        CHECKLIST_MOVING_TITLE_1(),
        CHECKLIST_MOVING_TITLE_2(),
        CHECKLIST_MOVING_TITLE_3(),
        CHECKLIST_MOVING_TITLE_4(),
        CHECKLIST_MOVING_TITLE_5(),
        CHECKLIST_MOVING_TITLE_6()]
    
    private let contentArray: [[CheckListMovingContentMode]] = [
        [
            .Title(CHECKLIST_MOVING_QUESTION_1()),
            .Select(CHECKLIST_MOVING_SELECT_1_1()),
            .Select(CHECKLIST_MOVING_SELECT_1_2()),
            .Select(CHECKLIST_MOVING_SELECT_1_3()),
            .Select(CHECKLIST_MOVING_SELECT_1_4())
        ],
        [
            .Select(CHECKLIST_MOVING_SELECT_2_1()),
            .Select(CHECKLIST_MOVING_SELECT_2_2()),
            .Select(CHECKLIST_MOVING_SELECT_2_3()),
            .Select(CHECKLIST_MOVING_SELECT_2_4())
        ],
        [
            .Title(CHECKLIST_MOVING_QUESTION_3()),
            .Select(CHECKLIST_MOVING_SELECT_3_1()),
            .Select(CHECKLIST_MOVING_SELECT_3_2()),
            .Select(CHECKLIST_MOVING_SELECT_3_3()),
            .Select(CHECKLIST_MOVING_SELECT_3_4()),
            .Select(CHECKLIST_MOVING_SELECT_3_5()),
            .Select(CHECKLIST_MOVING_SELECT_3_6()),
            .Select(CHECKLIST_MOVING_SELECT_3_7()),
            .Select(CHECKLIST_MOVING_SELECT_3_8()),
            .Select(CHECKLIST_MOVING_SELECT_3_9()),
            .Select(CHECKLIST_MOVING_SELECT_3_10()),
            .Select(CHECKLIST_MOVING_SELECT_3_11()),
            .Select(CHECKLIST_MOVING_SELECT_3_12()),
            .Select(CHECKLIST_MOVING_SELECT_3_13()),
        ],
        [
            .Select(CHECKLIST_MOVING_SELECT_4_1()),
            .Select(CHECKLIST_MOVING_SELECT_4_2()),
            .Select(CHECKLIST_MOVING_SELECT_4_3()),
            .Select(CHECKLIST_MOVING_SELECT_4_4()),
            .Select(CHECKLIST_MOVING_SELECT_4_5()),
            .Select(CHECKLIST_MOVING_SELECT_4_6()),
            .Select(CHECKLIST_MOVING_SELECT_4_7()),
            .Select(CHECKLIST_MOVING_SELECT_4_8()),
            .Select(CHECKLIST_MOVING_SELECT_4_9()),
            .Select(CHECKLIST_MOVING_SELECT_4_10()),
            .Select(CHECKLIST_MOVING_SELECT_4_11())
        ],
        [
            .Select(CHECKLIST_MOVING_SELECT_5_1()),
            .Select(CHECKLIST_MOVING_SELECT_5_2()),
            .Select(CHECKLIST_MOVING_SELECT_5_3()),
            .Select(CHECKLIST_MOVING_SELECT_5_4())
        ],
        [
            .Select(CHECKLIST_MOVING_SELECT_6_1()),
            .Select(CHECKLIST_MOVING_SELECT_6_2()),
            .Select(CHECKLIST_MOVING_SELECT_6_3()),
            .Select(CHECKLIST_MOVING_SELECT_6_4())
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
    
    private let dataHandle = CheckListType.Moving
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = CHECKLIST_TITLE_2()
        resetButtonItem.title = RESET()
        
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

    @IBAction func resetItemClicked(sender: AnyObject) {
        selectedData = [Int]()
        dataHandle.resetData()
    }
}

// MARK: - UITableView Data Source
extension CheckListMovingViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return titleArray.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(CheckListMoveCell)) as! CheckListMoveCell
        
        let message = contentArray[indexPath.section][indexPath.row]
        
        cell.contentLabel.text = message.message
        
        let smallEdge: CGFloat = message.selectable() ? 10 : 0
        cell.topConstraint.constant    = smallEdge
        cell.bottomConstraint.constant = smallEdge
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return contentArray[indexPath.section][indexPath.row].selectable()
    }
}

// MARK: - UITableView Delegate
extension CheckListMovingViewController {
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

class CheckListMoveCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
}