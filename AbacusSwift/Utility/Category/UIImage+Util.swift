//
//  UIImage+Util.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     获取纯背景色图片 大小1*1
     */
    public class func imageColor(color: UIColor) -> UIImage {
        return UIImage.imageColor(color, size: CGSize(width: 1, height: 1))
    }
    
    /**
     获取纯背景色图片
     
     - parameter color: 图片颜色
     - parameter size:  图片大小
     
     - returns: 纯背景色图片
     */
    public class func imageColor(color: UIColor, var size: CGSize) -> UIImage {
        if CGSizeEqualToSize(size, CGSize.zero) {
            size = CGSize(width: 1, height: 1)
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
        color.set()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}