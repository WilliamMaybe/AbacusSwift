//
//  UIFont+Util.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/11/23.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

import UIKit

extension UIFont {
    class func font_hn_bold(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "HelveticaNeue-Bold", size: size)
    }
    
    class func font_hn_ultralight(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "HelveticaNeue-UltraLight", size: size)
    }
    
    class func font_hn_medium(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "HelveticaNeue-Medium", size: size)
    }
    
    class func font_hn_light(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "HelveticaNeue-Light", size: size)
    }
    
    class func font_hn_regular(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "HelveticaNeue", size: size)
    }

}
