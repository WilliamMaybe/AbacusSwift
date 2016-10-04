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
    case title(String)
    case select(String)
    
    var message: String {
        get {
            switch self {
            case let .select(string): return string
            case let .title(string):  return string
            }
        }
    }
    
    func selectable() -> Bool {
        if case .select(_) = self {
            return true
        }
        return false
    }
}

class CheckListMovingViewController: UITableViewController {
    
    @IBOutlet weak var resetButtonItem: UIBarButtonItem!
    
    // MARK: - Variables
    fileprivate let titleArray = [
        CHECKLIST_MOVING_TITLE_1(),
        CHECKLIST_MOVING_TITLE_2(),
        CHECKLIST_MOVING_TITLE_3(),
        CHECKLIST_MOVING_TITLE_4(),
        CHECKLIST_MOVING_TITLE_5(),
        CHECKLIST_MOVING_TITLE_6()]
    
    fileprivate let contentArray: [[CheckListMovingContentMode]] = [
        [
            .title(CHECKLIST_MOVING_QUESTION_1()),
            .select(CHECKLIST_MOVING_SELECT_1_1()),
            .select(CHECKLIST_MOVING_SELECT_1_2()),
            .select(CHECKLIST_MOVING_SELECT_1_3()),
            .select(CHECKLIST_MOVING_SELECT_1_4())
        ],
        [
            .select(CHECKLIST_MOVING_SELECT_2_1()),
            .select(CHECKLIST_MOVING_SELECT_2_2()),
            .select(CHECKLIST_MOVING_SELECT_2_3()),
            .select(CHECKLIST_MOVING_SELECT_2_4())
        ],
        [
            .title(CHECKLIST_MOVING_QUESTION_3()),
            .select(CHECKLIST_MOVING_SELECT_3_1()),
            .select(CHECKLIST_MOVING_SELECT_3_2()),
            .select(CHECKLIST_MOVING_SELECT_3_3()),
            .select(CHECKLIST_MOVING_SELECT_3_4()),
            .select(CHECKLIST_MOVING_SELECT_3_5()),
            .select(CHECKLIST_MOVING_SELECT_3_6()),
            .select(CHECKLIST_MOVING_SELECT_3_7()),
            .select(CHECKLIST_MOVING_SELECT_3_8()),
            .select(CHECKLIST_MOVING_SELECT_3_9()),
            .select(CHECKLIST_MOVING_SELECT_3_10()),
            .select(CHECKLIST_MOVING_SELECT_3_11()),
            .select(CHECKLIST_MOVING_SELECT_3_12()),
            .select(CHECKLIST_MOVING_SELECT_3_13()),
        ],
        [
            .select(CHECKLIST_MOVING_SELECT_4_1()),
            .select(CHECKLIST_MOVING_SELECT_4_2()),
            .select(CHECKLIST_MOVING_SELECT_4_3()),
            .select(CHECKLIST_MOVING_SELECT_4_4()),
            .select(CHECKLIST_MOVING_SELECT_4_5()),
            .select(CHECKLIST_MOVING_SELECT_4_6()),
            .select(CHECKLIST_MOVING_SELECT_4_7()),
            .select(CHECKLIST_MOVING_SELECT_4_8()),
            .select(CHECKLIST_MOVING_SELECT_4_9()),
            .select(CHECKLIST_MOVING_SELECT_4_10()),
            .select(CHECKLIST_MOVING_SELECT_4_11())
        ],
        [
            .select(CHECKLIST_MOVING_SELECT_5_1()),
            .select(CHECKLIST_MOVING_SELECT_5_2()),
            .select(CHECKLIST_MOVING_SELECT_5_3()),
            .select(CHECKLIST_MOVING_SELECT_5_4())
        ],
        [
            .select(CHECKLIST_MOVING_SELECT_6_1()),
            .select(CHECKLIST_MOVING_SELECT_6_2()),
            .select(CHECKLIST_MOVING_SELECT_6_3()),
            .select(CHECKLIST_MOVING_SELECT_6_4())
        ]
    ]
    
    fileprivate var selectedData = [Int]() {
        willSet {
            for index in selectedData {
                self.tableView.deselectRow(at: IndexPath(item: index % 100, section: index / 100), animated: false)
            }
        }
        
        didSet {
            for index in selectedData {
                self.tableView.selectRow(at: IndexPath(item: index % 100, section: index / 100), animated: false, scrollPosition: .none)
            }
        }
    }
    
    fileprivate let dataHandle = CheckListType.moving
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = CHECKLIST_TITLE_2()
        resetButtonItem.title = RESET()
        
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

    @IBAction func resetItemClicked(_ sender: AnyObject) {
        selectedData = [Int]()
        dataHandle.resetData()
    }
}

// MARK: - UITableView Data Source
extension CheckListMovingViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CheckListMoveCell.self)) as! CheckListMoveCell
        
        let message = contentArray[indexPath.section][indexPath.row]
        
        cell.contentLabel.text = message.message
        
        let smallEdge: CGFloat = message.selectable() ? 10 : 0
        cell.topConstraint.constant    = smallEdge
        cell.bottomConstraint.constant = smallEdge
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return contentArray[indexPath.section][indexPath.row].selectable()
    }
}

// MARK: - UITableView Delegate
extension CheckListMovingViewController {
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
        selectedData.append(indexPath.row + indexPath.section * 100)
        dataHandle.addOrDeleteIdentifier(indexPath.row + indexPath.section * 100)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedData = selectedData.filter { $0 != indexPath.row + indexPath.section * 100 }
        dataHandle.addOrDeleteIdentifier(indexPath.row + indexPath.section * 100)
    }
}

class CheckListMoveCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
}
