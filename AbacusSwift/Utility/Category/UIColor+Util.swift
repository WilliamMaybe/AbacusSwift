//
//  UIColor+Util.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  UIColor 扩展类

import UIKit

extension UIColor {
    class func color(red red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor.color(red: red, g: green, b: blue, alpha: 1)
    }
    class func color(red red: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat(red) / 255.0,
          green: CGFloat(g) / 255.0,
           blue: CGFloat(b) / 255.0,
          alpha: alpha)
    }
    
    class func color(hex hexValue: Int) -> UIColor {
        return UIColor.color(hex: hexValue, alpha: 1)
    }
    class func color(hex hexValue: Int, alpha: CGFloat) -> UIColor {
        return UIColor.color(
            red: (hexValue & 0xFF0000) >> 16,
              g: (hexValue & 0xFF00) >> 8,
              b: (hexValue & 0xFF),
          alpha: alpha)
    }
    
    class func color(w white: Int)  -> UIColor {
        return UIColor.color(w: white, alpha: 1)
    }
    class func color(w white: Int, alpha: CGFloat) -> UIColor {
        return UIColor(white: CGFloat(white) / 255, alpha: alpha)
    }
}

extension UIColor {
    /**************** 本产品使用  ******************/
    class func themeGreen() -> UIColor {
        return UIColor.color(red: 88, green: 119, blue: 62)
    }
    
    class func themeLightGreen() -> UIColor {
        return UIColor.color(red: 160, green: 183, blue: 142)
    }
    
    class func themeGray() -> UIColor {
        return UIColor.color(red: 238, green: 241, blue: 235)
    }
    
    class func themeYellow() ->UIColor {
        return UIColor.color(red: 235, green: 182, blue: 68)
    }
    
    class func themeFont() -> UIColor {
        return UIColor.color(w: 93)
    }
    /**************** 本产品使用  ******************/

}