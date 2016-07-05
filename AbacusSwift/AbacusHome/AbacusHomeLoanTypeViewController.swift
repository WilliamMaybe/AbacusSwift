//
//  AbacusHomeLoanTypeViewController.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/1/10.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit
import SafariServices

public enum LoanTypes: Int {
    case Residential, Commercial
}

class AbacusHomeLoanTypeViewController: UITableViewController {
    
    private var loanType = LoanTypes.Residential
    private var dataArray = [LoanModel]()
    private var page = 0 // API use
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: 50)))
        
        button.addTarget(self, action: #selector(AbacusHomeLoanTypeViewController.loadNextPage), forControlEvents: .TouchUpInside)
        button.setTitleColor(UIColor.grayColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        
        return button
    }()
    
    init(loanTypes: LoanTypes) {
        loanType = loanTypes
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var titleTranslate = ""
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(AbacusHomeLoanTypeViewController.pullToRefresh), forControlEvents: .ValueChanged)
        
        tableView.backgroundColor = UIColor.themeGray()
        
        switch loanType {
            case .Residential : titleTranslate = ABACUS_LOAN_TITLE_1
            case .Commercial : titleTranslate = ABACUS_LOAN_TITLE_2
        }
        title = localStringFromKey(titleTranslate)
        
        pullToRefresh()
    }
}

// MARK: - Load Request
extension AbacusHomeLoanTypeViewController {
    func pullToRefresh() {
        refreshControl?.beginRefreshing()
        moreButton.enabled = false
        request(0)
    }
    
    func loadNextPage() {
        moreButton.setTitle("loading...", forState: .Normal)
        moreButton.enabled = false
        request(self.page)
    }
    
    func handleButtonState(total: Int) {
        if (dataArray.count >= total) {
            tableView.tableFooterView = nil
        } else {
            tableView.tableFooterView = moreButton
            moreButton.setTitle("read more", forState: .Normal)
            moreButton.enabled = true
        }
    }
    
    // MARK: - Request API
    private func request(page: Int) {
        let requestType = (loanType == .Residential) ? Loan.Residential(page) : .Commercial(page)
        
        requestType.request(success: { (loanArray, total) -> Void in
            self.page += 1
            if page == 0 {
                self.dataArray.removeAll()
                self.page = 1
            }
            self.dataArray += loanArray
            self.tableView.reloadData()
            
            if (self.refreshControl?.refreshing == true) {
                self.refreshControl?.endRefreshing()
            }
            
            self.handleButtonState(total)
            
            }, failure: {(errorMessage) -> Void in
                print(errorMessage)
                self.refreshControl?.endRefreshing()
                self.moreButton.enabled = true
        })
    }
}

// MARK: - UITableView Delegate & DataSource
extension AbacusHomeLoanTypeViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil  {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            cell?.accessoryType = .DisclosureIndicator
            cell?.textLabel!.textColor = UIColor.themeGreen()
        }
        
        let model = dataArray[indexPath.row]
        cell?.textLabel?.text = model.title
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
    
        let model = dataArray[indexPath.row]
    
        guard let url = NSURL(string: Loan.Residential(0).baseURL + "/html/NewDetail.html?id=" + model.newsId) else {
            return
        }
    
        let safariVC = SFSafariViewController(URL: url)
        self.presentViewController(safariVC, animated: true, completion: nil)
    }
}
