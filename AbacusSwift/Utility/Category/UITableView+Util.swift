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
    func dequeueReusableCellClass(aClass: AnyClass) -> UITableViewCell?
}

extension UITableView: UITableViewRegisterProtocol {
  
    func registerHeaderFooterViewClass(aClass: AnyClass) {
        self.registerClass(aClass, forHeaderFooterViewReuseIdentifier: String(aClass))
    }
    
    func registerCellClass(aClass: AnyClass) {
        self.registerClass(aClass, forCellReuseIdentifier: String(aClass))
    }
    
    func dequeueReusableCellClass(aClass: AnyClass) -> UITableViewCell? {
        return self.dequeueReusableCellWithIdentifier(String(aClass))
    }
}

private var staticToken: dispatch_once_t = 0
extension UITableView {
    public override class func initialize() {
        dispatch_once(&staticToken) { 
            let originalSel = #selector(UITableView.init(frame:style:))
            let swizzledSel = #selector(UITableView.init(wz_frame:style:))
            
            let originalMethod = class_getInstanceMethod(self, originalSel)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSel)
            
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    public convenience init(wz_frame: CGRect, style: UITableViewStyle) {
        self.init(wz_frame: wz_frame, style: style)
        if respondsToSelector(Selector("setSeparatorInset:")) {
            separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        }
        
        if respondsToSelector(Selector("setLayoutMargins:")) {
            layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        }
    }
}