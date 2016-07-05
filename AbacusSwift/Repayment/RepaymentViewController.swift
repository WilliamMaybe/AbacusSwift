//
//  RepaymentViewController.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  贷款利息计算主页

import UIKit

class RepaymentViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = localStringFromKey(REPAYMENT)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: localStringFromKey(RESET), style: .Plain, target: self, action: #selector(RepaymentViewController.clickToReset))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(RepaymentViewController.clickToMail))
        
        initComponents()
    }
    
    private func initComponents() {
        
    }
    
    // MARK: - Button Click
    @objc private func clickToReset() {
        
    }
    
    @objc private func clickToMail() {
        
    }
}