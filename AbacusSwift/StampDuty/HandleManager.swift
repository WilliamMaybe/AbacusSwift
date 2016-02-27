//
//  HandleManager.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/11/26.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  计算stampduty 结果

import Foundation

func stampDutyPickerTitle(index: Int) -> String {
    return localStringFromKey("\(STAMPDUTY_PICKER)\(index)")
}

func stampDutyPickerFullTitle(index: Int) -> String {
    return localStringFromKey("\(STAMPDUTY_PICKER_FULL)\(index)")
}

func stampDutyPickerTitleArray(full: Bool) -> [String] {
    var array = [String]()
    for i in 1...stampDutyPickerCount {
        if full {
            array.append(stampDutyPickerFullTitle(i))
        } else {
            array.append(stampDutyPickerTitle(i))
        }
    }
    return array
}

let stampDutyPickerCount = 8

let stampDutyURL = [
    "http://www.revenue.act.gov.au/",
    "http://www.osr.nsw.gov.au/",
    "http://www.treasury.nt.gov.au/",
    "https://www.osr.qld.gov.au/",
    "http://www.revenuesa.sa.gov.au/",
    "http://www.sro.tas.gov.au/",
    "http://www.sro.vic.gov.au/",
    "http://www.finance.wa.gov.au/"
]


enum stampDutyType: Int {
    case act ,nsw ,nt ,qld ,sa ,tas ,vic ,wa
    
    
}

class stampDutyModel {
    var type: stampDutyType = .act
    var money: Double = 0.0
    var isLive: Bool = false
    var isFirstBuy: Bool = false
    
    var fullStateName: String {
        return stampDutyPickerFullTitle(type.rawValue + 1)
    }
    
    var stateName: String {
        return stampDutyPickerTitle(type.rawValue + 1)
    }
    
    init() {}
}

class stampDutyResultModel {
    var type: stampDutyType
    var stampduty: Double = 0.0
    var transfer: Double = 0.0
    var regist: Double = 0.0
    var total: Double {
        return stampduty + transfer + regist
    }
    
    var fullStateName: String {
        return stampDutyPickerFullTitle(type.rawValue + 1)
    }
    
    var stateName: String {
        return stampDutyPickerTitle(type.rawValue + 1)
    }
    
    init(type: stampDutyType) {
        self.type = type
    }
}

func handleMoney(pendModel: stampDutyModel) -> stampDutyResultModel {
    // 以下为各方法计算公式
    func calculateact(pendModel: stampDutyModel) -> stampDutyResultModel {
        let result = stampDutyResultModel(type: pendModel.type)
        result.regist = 125
        result.transfer = 243
        
        let amount = [200000.0,300000.0,500000.0,750000.0,1000000.0,1455000.0]
        let rate   = [2.00,3.50,4.15,5.00,6.50,7.00,5.25]
        
        var tmpPlus = [0.0,0.0,0,0,0,0]
        tmpPlus[0] = amount[0] * rate[0] / 100;
        for i in 1..<5 {
            tmpPlus[i] = tmpPlus[i - 1] + (amount[i] - amount[i - 1]) * rate[i] / 100;
        }
        
        let money = pendModel.money
        
        if money > amount[5] {
            result.stampduty = money / 100 * rate[6]
        } else if money <= amount[0] {
            result.stampduty = (money / 100 * rate[0]) > 20 ? (money / 100 * rate[0]) : 20
        }
        else {
            for (var i = 4; i >= 0; i--) {
                if money <= amount[i] {
                    continue
                }
                
                result.stampduty = (money - amount[i]) / 100 * rate[i + 1] + tmpPlus[i]
                break
            }
        }
        
        return result
    }
    
    func calculatensw(pendModel: stampDutyModel) -> stampDutyResultModel {
        let result = stampDutyResultModel(type: pendModel.type)
        result.regist = 107.0;
        result.transfer = 214.0;
        
        let amount  = [14000.0,30000.0,80000.0,300000.0,1000000.0,3000000.0]
        let rate    = [1.25,1.50,1.75,3.50,4.50,5.50,7.00]
        
        var tmpPlus = [0.0,0,0,0,0,0]
        tmpPlus[0] = amount[0] * rate[0] / 100;
        for i in 1..<6 {
            tmpPlus[i] = tmpPlus[i - 1] + (amount[i] - amount[i - 1]) * rate[i] / 100;
        }
        
        let money = pendModel.money
        
        if money <= amount[0] {
            result.stampduty = money / 100 * rate[0];
        } else {
            for (var i = 5; i >= 0; i--) {
                if money <= amount[i] {
                    continue
                }
                
                result.stampduty = (money - amount[i]) / 100 * rate[i + 1] + tmpPlus[i]
                break
            }
        }
        
        return result
    }
    func calculatent(pendModel: stampDutyModel) -> stampDutyResultModel {
        let result = stampDutyResultModel(type: pendModel.type)
        result.regist = 137.0
        result.transfer = 137.0
        
        let amount  = [525000.0,3000000.0]
        let rate    = [0.06571441,4.95,5.45]
        
        var tmpPlus = [0,0.0]
        let v = amount[0] / 1000.0;
        tmpPlus[0] = (0.06571441 * v * v) + 15 * v
        tmpPlus[1] = tmpPlus[0] + (amount[1] - amount[0]) * rate[1] / 100
        
        let money = pendModel.money
        if (money > amount[1]) {
            result.stampduty = (money - amount[1]) * rate[2] / 100 + tmpPlus[1]
        }
        else if (money > amount[0]) {
            result.stampduty = (money - amount[0]) * rate[1] / 100 + tmpPlus[0]
        }
        else {
            let v = money / 1000.0;
            result.stampduty = (rate[0] * v * v) + 15 * v;
        }
        
        return result
    }
    func calculateqld(pendModel: stampDutyModel) -> stampDutyResultModel {
        let result = stampDutyResultModel(type: pendModel.type)
        let money = pendModel.money
        result.regist = 163.0
        result.transfer = 157.4 + (money > 180000.0 ? ((money - 180000.0) / 10000.0 * 29.8) : 0)
        
        var amount: [Double]
        var rate: [Double]
        var tmpPlus: [Double] = []
        
        // to live
        if(pendModel.isLive) {
            amount = [350000.0,540000.0,1000000.0]
            rate = [1.0,3.50,4.50,5.75]
            
            tmpPlus.append(amount[0] * rate[0] / 100)
            tmpPlus.append(tmpPlus[0] + (amount[1] - amount[0]) * rate[1] / 100)
            tmpPlus.append(tmpPlus[1] + (amount[2] - amount[1]) * rate[2] / 100)
        }
        else {
            // not to live
            amount = [5000.0,75000.0,540000.0,1000000.0]
            rate = [1.50,3.50,4.50,5.75]
            
            tmpPlus.append(0)
            tmpPlus.append((amount[1] - amount[0]) * rate[0] / 100)
            tmpPlus.append(tmpPlus[0] + (amount[2] - amount[1]) * rate[1] / 100)
            tmpPlus.append(tmpPlus[1] + (amount[3] - amount[2]) * rate[2] / 100)
        }
        
        if (money <= amount[0]) {
            result.stampduty = pendModel.isLive ? (money / 100 * rate[0]) : 0
        } else {
            for (var i = amount.count - 1; i >= 0; i--) {
                if (money <= amount[i]) {
                    continue
                }
                
                result.stampduty = (money - amount[i]) / 100 * rate[i + (pendModel.isLive ? 1 : 0)] + tmpPlus[i]
                break
            }
        }
        
        return result
    }
    
    func calculatesa(pendModel: stampDutyModel) -> stampDutyResultModel {
        let result = stampDutyResultModel(type: pendModel.type)
        result.regist = 152
        
        let money = pendModel.money
        
        // Transfer fee
        switch money {
        case 0...5000:      result.transfer = 152
        case 5000...20000:  result.transfer = 167
        case 20000...40000: result.transfer = 184
        case 40000...50000: result.transfer = 258
        default:
            let diffValue = money - 50001
            result.transfer = 258 + 75.5 * (diffValue / 10000 + 1)
        }
        
        // stamp duty
        let amount  = [12000.0,30000.0,50000.0,100000.0,200000.0,250000.0,300000.0,500000.0]
        let rate    = [1.0,2.0,3.0,3.50,4.00,4.25,4.75,5.00,5.50]
        var tmpPlus = [0,0,0,0,0,0,0,0.0]
        tmpPlus[0] = amount[0] * rate[0] / 100
        for i in 1..<8 {
            tmpPlus[i] = tmpPlus[i - 1] + (amount[i] - amount[i - 1]) * rate[i] / 100
        }
        
        if (money <= amount[0]) {
            result.stampduty = money / 100 * rate[0]
        } else {
            for (var i = 7; i >= 0; i-- ) {
                if (money <= amount[i]) {
                    continue
                }
                
                result.stampduty = (money - amount[i]) / 100 * rate[i + 1] + tmpPlus[i]
                break
            }
        }
        
        return result
    }
    
    func calculatetas(pendModel: stampDutyModel) -> stampDutyResultModel {
        let result = stampDutyResultModel(type: pendModel.type)
        result.regist = 127.0
        result.transfer = 191.26
        
        let amount = [3000.0,25000.0,75000.0,200000.0,375000.0,725000.0]
        let rate = [1.75,2.25,3.50,4.00,4.25,4.50]
        var tmpPlus = [0.0,0,0,0,0,0.0]
        tmpPlus[0] = 50
        for i in 1...5 {
            tmpPlus[i] = tmpPlus[i - 1] + (amount[i] - amount[i-1]) / 100 * rate[i - 1]
        }
        
        let money = pendModel.money
        
        if (money <= amount[0]) {
            result.stampduty = 50
        } else {
            for (var i = 5; i >= 0; i--) {
                if (money <= amount[i]) {
                    continue
                }
                
                result.stampduty = (money - amount[i]) / 100 * rate[i] + tmpPlus[i]
                break
            }
        }
        
        return result
    }
    
    func calculatevic(pendModel: stampDutyModel) -> stampDutyResultModel {
        let result = stampDutyResultModel(type: pendModel.type)
        result.regist = 111
        
        let moeny = pendModel.money
        result.transfer = min((131 + moeny / 1000 * 2.46) ,1362)
        
        func noLive(money: Double) -> Double {
            let amount = [25000.0,130000.0,960000.0]
            let rate = [1.4,2.4,6.0,5.5]
            var tmpPlus = [0.0,0]
            tmpPlus[0] = amount[0] * rate[0] / 100
            tmpPlus[1] = tmpPlus[0] + (amount[1] - amount[0]) * rate[1] / 100
            
            switch money {
            case 0...amount[0]:         return money * rate[0] / 100;
            case amount[0]...amount[1]: return (money - amount[0]) * rate[1] / 100 + tmpPlus[0]
            case amount[1]...amount[2]: return (money - amount[1]) * rate[2] / 100 + tmpPlus[1]
            default:                    return money * rate[3] / 100
            }
        }
        
        func live(money: Double) -> Double {
            if (pendModel.isLive) {
                let amount = [130000.0,440000.0,550000.0]
                let rate   = [5.0,6.0]
                var tmpPlus = [0,0.0]
                tmpPlus[0] = noLive(amount[0])
                tmpPlus[1] = tmpPlus[0] + (amount[1] - amount[0]) * rate[0] / 100
                
                switch money {
                case amount[0]...amount[1]: return (money - amount[0]) / 100 * rate[0] + tmpPlus[0]
                case amount[1]...amount[2]: return (money - amount[1]) / 100 * rate[1] + tmpPlus[1]
                case 0...amount[0]: fallthrough
                default: return noLive(moeny)
                }
            }
            
            return noLive(moeny)
        }
        
        result.transfer = live(moeny)
        return result
    }
    
    func calculatewa(pendModel: stampDutyModel) -> stampDutyResultModel {
        let result = stampDutyResultModel(type: pendModel.type)
        result.regist = 160
        result.transfer = 160
        
        let amount = [80000.0,100000.0,250000.0,500000.0]
        let rate   = [1.90,2.85,3.80,4.75,5.15]
        var tmpPlus = [0.0,0,0,0]
        tmpPlus[0] = amount[0] * rate[0] / 100
        for i in 1..<amount.count {
            tmpPlus[i] = tmpPlus[i - 1] + (amount[i] - amount[i - 1]) * rate[i] / 100
        }
        
        let money = pendModel.money
        if (money <= amount[0]) {
            result.stampduty = money / 100 * rate[0]
        } else {
            for (var i = amount.count - 1; i >= 0; i--) {
                if (money <= amount[i]) {
                    continue
                }
                
                result.stampduty = (money - amount[i]) / 100 * rate[i + 1] + tmpPlus[i]
                break
            }
        }
        
        return result
    }
    
    /* 计算结果 */
    switch pendModel.type {
    case .act: return calculateact(pendModel)
    case .nsw: return calculatensw(pendModel)
    case .nt:  return calculatent(pendModel)
    case .qld: return calculateqld(pendModel)
    case .sa:  return calculatesa(pendModel)
    case .tas: return calculatetas(pendModel)
    case .vic: return calculatevic(pendModel)
    case .wa:  return calculatewa(pendModel)
    }
}
