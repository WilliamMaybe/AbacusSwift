//
//  UIView+Util.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

import UIKit

extension UIView {
    /// 需扩张的尺寸
    public var expandSize: CGSize {
        get {
            if let value: NSValue = objc_getAssociatedObject(self, &AssociatedKeys.expandSizeKey) as? NSValue {
                return value.CGSizeValue()
            }
            self.expandSize = CGSize.zero
            return CGSize.zero
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.expandSizeKey, NSValue(CGSize: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    };
}

extension UIView {
    private struct AssociatedKeys {
        static var expandSizeKey = "wz_expandSize"
    }
    
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        if self != UIView.self {
            return
        }
        
        dispatch_once(&Static.token) {
            let originalSelector = #selector(UIView.intrinsicContentSize)
            let swizzledSelector = #selector(UIView.wz_intrinsicContentSize)
            
            let originalMethod = class_getClassMethod(self, originalSelector)
            let swizzledMethod = class_getClassMethod(self, swizzledSelector)
            
            if class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    
    @objc private func wz_intrinsicContentSize() -> CGSize {
        var size = self.wz_intrinsicContentSize();
        size.width += self.expandSize.width
        size.height += self.expandSize.height
        return size
    }
}