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
    let screenHeight = UIScreen.main.bounds.height
    if screenHeight > 568 {
        return (screenHeight - 568) / 2
    }
    
    return 0
}

/**
 *  格式化金钱，四舍五入不保留小数，$123,456显示
 */
extension Double {
    func moneyFormatter() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en-AU")
        formatter.numberStyle = .decimal
        return "$" + formatter.string(from: NSNumber(value: Int(self + 0.5)))!
    }
}
