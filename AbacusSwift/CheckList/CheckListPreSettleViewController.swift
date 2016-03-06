//
//  CheckListPreSettleViewController.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/2/28.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

class CheckListPreSettleViewController: UITableViewController {
    
    private lazy var sectionTitles =
    [   localStringFromKey(CHECKLIST_PRESETTLE_TITLE_1),
        localStringFromKey(CHECKLIST_PRESETTLE_TITLE_2)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(CheckListHeaderView.self, forHeaderFooterViewReuseIdentifier: String(CheckListHeaderView))
        tableView.estimatedSectionHeaderHeight = 30
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CheckListPreSettleViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
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