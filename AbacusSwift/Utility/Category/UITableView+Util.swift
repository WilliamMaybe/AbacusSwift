//
//  UITableView+Util.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/8/22.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

protocol UITableViewRegisterProtocol {
    func registerHeaderFooterViewClass(aClass: AnyClass)
    func registerCellClass(aClass: AnyClass)
}

extension UITableView: UITableViewRegisterProtocol {
  
    func registerHeaderFooterViewClass(aClass: AnyClass) {
        self.registerClass(aClass, forHeaderFooterViewReuseIdentifier: String(aClass))
    }
    
    func registerCellClass(aClass: AnyClass) {
        self.registerClass(aClass, forCellReuseIdentifier: String(aClass))
    }
}