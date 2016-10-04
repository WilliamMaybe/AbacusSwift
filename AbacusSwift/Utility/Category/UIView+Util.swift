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
                return value.cgSizeValue
            }
            self.expandSize = CGSize.zero
            return CGSize.zero
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.expandSizeKey, NSValue(cgSize: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    };
}

private let once: Void = {
    let originalSelector = #selector(getter: UIView.intrinsicContentSize)
    let swizzledSelector = #selector(UIView.wz_intrinsicContentSize)
    
    let originalMethod = class_getClassMethod(UIView.self, originalSelector)
    let swizzledMethod = class_getClassMethod(UIView.self, swizzledSelector)
    
    if class_addMethod(UIView.self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
        class_replaceMethod(UIView.self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}()

extension UIView {
    fileprivate struct AssociatedKeys {
        static var expandSizeKey = "wz_expandSize"
    }
    
    open override class func initialize() {
        if self != UIView.self {
            return
        }
        _ = once
    }
    
    @objc fileprivate func wz_intrinsicContentSize() -> CGSize {
        var size = self.wz_intrinsicContentSize();
        size.width += self.expandSize.width
        size.height += self.expandSize.height
        return size
    }
}
