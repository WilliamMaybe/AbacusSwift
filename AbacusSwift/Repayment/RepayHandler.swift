//
//  RepayHandler.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/9/4.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import Foundation

/**
 还款周期
 
 - monthly:     月还
 - fortnightly: 两周还
 - weekly:      周还
 */
enum RepayFrequency {
    case monthly
    case fortnightly
    case weekly
}

/**
 还款方式
 
 - principalAndInterest: 本金加利息
 - interestOnly:         利息
 */
enum RepayType {
    case principalAndInterest
    case interestOnly
}

class RepayModel {
    var money: Double = 600_000
     /// 年限
    var term: Int = 30
     /// 贷款利率
    var interestRate: Double = 0.0468
    
    var frequency = RepayFrequency.monthly
    var repayType = RepayType.principalAndInterest
    
    var extraPaid: Double = 0
}