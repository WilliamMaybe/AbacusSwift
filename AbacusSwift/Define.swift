//
//  Define.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/11/26.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

import UIKit

/**
 得到相对于3.5寸屏的高度差值
 */
func marginYFrom320() -> CGFloat {
    let screenHeight = UIScreen.mainScreen().bounds.height
    if screenHeight > 568 {
        return (screenHeight - 568) / 2
    }
    
    return 0
}

/**
 *  格式化金钱，四舍五入不保留小数，$123,456显示
 */
func formatterMoney(money: Double) -> String {
    let formatter = NSNumberFormatter()
    formatter.locale = NSLocale(localeIdentifier: "en-AU")
    formatter.numberStyle = .DecimalStyle
    return "$" + formatter.stringFromNumber(Int(money + 0.5))!
}