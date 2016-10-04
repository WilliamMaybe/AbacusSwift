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
    case residential, commercial
    
    var title: String {
        get {
            switch self {
            case .residential: return ABACUS_LOAN_TITLE_1()
            case.commercial:   return ABACUS_LOAN_TITLE_2()
            }
        }
    }
}

class AbacusHomeLoanTypeViewController: UITableViewController {
    
    fileprivate var loanType = LoanTypes.residential
    fileprivate var dataArray = [LoanModel]()
    fileprivate var page = 0 // API use
    
    fileprivate lazy var moreButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: 50)))
        
        button.addTarget(self, action: #selector(loadNextPage), for: .touchUpInside)
        button.setTitleColor(UIColor.gray, for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
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
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.backgroundColor = UIColor.themeGray()
        
        title = loanType.title
        
        pullToRefresh()
    }
}

// MARK: - Load Request
extension AbacusHomeLoanTypeViewController {
    func pullToRefresh() {
        refreshControl?.beginRefreshing()
        moreButton.isEnabled = false
        request(0)
    }
    
    func loadNextPage() {
        moreButton.setTitle("loading...", for: UIControlState())
        moreButton.isEnabled = false
        request(self.page)
    }
    
    func handleButtonState(_ total: Int) {
        if (dataArray.count >= total) {
            tableView.tableFooterView = nil
        } else {
            tableView.tableFooterView = moreButton
            moreButton.setTitle("read more", for: UIControlState())
            moreButton.isEnabled = true
        }
    }
    
    // MARK: - Request API
    fileprivate func request(_ page: Int) {
        let requestType = (loanType == .residential) ? Loan.residential(page) : .commercial(page)
        
        requestType.request(success: { (loanArray, total) -> Void in
            self.page += 1
            if page == 0 {
                self.dataArray.removeAll()
                self.page = 1
            }
            self.dataArray += loanArray
            self.tableView.reloadData()
            
            if (self.refreshControl?.isRefreshing == true) {
                self.refreshControl?.endRefreshing()
            }
            
            self.handleButtonState(total)
            
            }, failure: {(errorMessage) -> Void in
                print(errorMessage)
                self.refreshControl?.endRefreshing()
                self.moreButton.isEnabled = true
        })
    }
}

// MARK: - UITableView Delegate & DataSource
extension AbacusHomeLoanTypeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil  {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel!.textColor = UIColor.themeGreen()
        }
        
        let model = dataArray[indexPath.row]
        cell?.textLabel?.text = model.title
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
    
        let model = dataArray[indexPath.row]
    
        guard let url = URL(string: Loan.residential(0).baseURL + "/html/NewDetail.html?id=" + model.newsId) else {
            return
        }
    
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}
