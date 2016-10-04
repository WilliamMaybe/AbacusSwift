//
//  UITableView+Util.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/8/22.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

protocol UITableViewRegisterProtocol {
    func registerHeaderFooterViewClass(_ aClass: AnyClass)
    func registerCellClass(_ aClass: AnyClass)
    func dequeueReusableCellClass(_ aClass: AnyClass) -> UITableViewCell?
}

extension UITableView: UITableViewRegisterProtocol {
  
    func registerHeaderFooterViewClass(_ aClass: AnyClass) {
        self.register(aClass, forHeaderFooterViewReuseIdentifier: String(describing: aClass))
    }
    
    func registerCellClass(_ aClass: AnyClass) {
        self.register(aClass, forCellReuseIdentifier: String(describing: aClass))
    }
    
    func dequeueReusableCellClass(_ aClass: AnyClass) -> UITableViewCell? {
        return self.dequeueReusableCell(withIdentifier: String(describing: aClass))
    }
}

private let once: Void = {
    let originalSel = #selector(UITableView.init(frame:style:))
    let swizzledSel = #selector(UITableView.init(wz_frame:style:))
    
    let originalMethod = class_getInstanceMethod(UITableView.self, originalSel)
    let swizzledMethod = class_getInstanceMethod(UITableView.self, swizzledSel)
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
}()

extension UITableView {
    open override class func initialize() {
        _ = once
    }
    
    public convenience init(wz_frame: CGRect, style: UITableViewStyle) {
        self.init(wz_frame: wz_frame, style: style)
        if responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        }
        
        if responds(to: #selector(setter: UIView.layoutMargins)) {
            layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        }
    }
}
