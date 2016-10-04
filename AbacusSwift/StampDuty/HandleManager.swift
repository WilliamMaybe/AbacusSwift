//
//  HandleManager.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/11/26.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  计算stampduty 结果

import Foundation

/**
 *  印花税的基本属性
 */
protocol stampDutyProtocol {
    var pickerTitle: String { get }
    var pickerFullTitle: String { get }
    var url: String { get }
}

protocol stampDutyInput {
    var money:      Double { set get }
    var isLive:     Bool { set get }
    
    var model: stampDutyModel { get }
}

protocol stampDutyHandler {
    var stampduty:  Double { get }
    var transfer:   Double { get }
    var regist:     Double { get }
    var total:      Double { get }
    
    func calculate()
}

class stampDutyModel {
    // input
    var money: Double    = 0.0
    var isLive: Bool     = false
    
    // output
    var stampduty: Double = 0.0
    var transfer: Double  = 0.0
    var regist: Double    = 0.0
}

enum stampDutyType {
    case act(stampDutyModel)
    case nsw(stampDutyModel)
    case nt(stampDutyModel)
    case qld(stampDutyModel)
    case sa(stampDutyModel)
    case tas(stampDutyModel)
    case vic(stampDutyModel)
    case wa(stampDutyModel)
}

extension stampDutyType: stampDutyProtocol {
    
    var pickerTitle: String {
        switch self {
        case .act(_): return STAMPDUTY_PICKER_1()
        case .nsw(_): return STAMPDUTY_PICKER_2()
        case .nt(_):  return STAMPDUTY_PICKER_3()
        case .qld(_): return STAMPDUTY_PICKER_4()
        case .sa(_):  return STAMPDUTY_PICKER_5()
        case .tas(_): return STAMPDUTY_PICKER_6()
        case .vic(_): return STAMPDUTY_PICKER_7()
        case .wa(_):  return STAMPDUTY_PICKER_8()
        }
    }
    
    var pickerFullTitle: String {
        switch self {
        case .act(_): return STAMPDUTY_PICKER_FULL_1()
        case .nsw(_): return STAMPDUTY_PICKER_FULL_2()
        case .nt(_):  return STAMPDUTY_PICKER_FULL_3()
        case .qld(_): return STAMPDUTY_PICKER_FULL_4()
        case .sa(_):  return STAMPDUTY_PICKER_FULL_5()
        case .tas(_): return STAMPDUTY_PICKER_FULL_6()
        case .vic(_): return STAMPDUTY_PICKER_FULL_7()
        case .wa(_):  return STAMPDUTY_PICKER_FULL_8()
        }
    }
    
    var url: String {
        switch self {
        case .act(_): return "http://www.revenue.act.gov.au/"
        case .nsw(_): return "http://www.osr.nsw.gov.au/"
        case .nt(_):  return "http://www.treasury.nt.gov.au/"
        case .qld(_): return "https://www.osr.qld.gov.au/"
        case .sa(_):  return "http://www.revenuesa.sa.gov.au/"
        case .tas(_): return "http://www.sro.tas.gov.au/"
        case .vic(_): return "http://www.sro.vic.gov.au/"
        case .wa(_):  return "http://www.finance.wa.gov.au/"
        }
    }
}

extension stampDutyType: stampDutyInput {
    var money: Double {
        get {
            return model.money
        }
        set {
            model.money = newValue
        }
    }
    
    var isLive: Bool {
        get {
            return model.isLive
        }
        set {
            model.isLive = newValue
        }
    }
    
    var model: stampDutyModel {
        switch self {
        case let .act(model): return model
        case let .nsw(model): return model
        case let .nt(model):  return model
        case let .qld(model): return model
        case let .sa(model):  return model
        case let .tas(model): return model
        case let .vic(model): return model
        case let .wa(model):  return model
        }
    }
}

extension stampDutyType: stampDutyHandler {
    var stampduty: Double {
        return model.stampduty
    }
    
    var transfer: Double {
        return model.transfer
    }
    
    var regist: Double {
        return model.regist
    }
    
    var total: Double {
        return stampduty + transfer + regist
    }
    
    func calculate() {
        resetOutput()
        
        switch self {
            case .act(_): actCalculate()
            case .nsw(_): nswCalculate()
            case .nt(_):  ntCalculate()
            case .qld(_): qldCalculate()
            case .sa(_):  saCalculate()
            case .tas(_): tasCalculate()
            case .vic(_): vicCalculate()
            case .wa(_):  waCalculate()
        }
    }
}

// MARK: - 各个类型计算公式
private extension stampDutyType {
    func resetOutput() {
        model.stampduty = 0
        model.transfer  = 0
        model.regist    = 0
    }
    
    func actCalculate() {
        model.regist   = 125
        model.transfer = 243
        
        let amount = [200000.0,300000.0,500000.0,750000.0,1000000.0,1455000.0]
        let rate   = [2.00,3.50,4.15,5.00,6.50,7.00,5.25]
        
        var tmpPlus = [Double]()
        tmpPlus.append(amount[0] * rate[0] / 100)
        for i in 1..<amount.count - 1 {
            tmpPlus.append(tmpPlus[i - 1] + (amount[i] - amount[i - 1]) * rate[i] / 100)
        }
        
        if money > amount[5] {
            model.stampduty = money / 100 * rate[6]
        } else if money <= amount[0] {
            model.stampduty = (money / 100 * rate[0]) > 20 ? (money / 100 * rate[0]) : 20
        }
        else {
            for i in (0...4).reversed() {
                if money <= amount[i] {
                    continue
                }
                
                model.stampduty = (money - amount[i]) / 100 * rate[i + 1] + tmpPlus[i]
                break
            }
        }
    }
    
    func nswCalculate() {
        model.regist   = 107
        model.transfer = 214
        
        let amount  = [14000.0,30000.0,80000.0,300000.0,1000000.0,3000000.0]
        let rate    = [1.25,1.50,1.75,3.50,4.50,5.50,7.00]
        
        var tmpPlus = [amount[0] * rate[0] / 100]
        for i in 1..<amount.count {
            tmpPlus.append(tmpPlus[i - 1] + (amount[i] - amount[i - 1]) * rate[i] / 100)
        }
        
        if money <= amount[0] {
            model.stampduty = money / 100 * rate[0];
            return
        }
        
        for i in (0...5).reversed() {
            if money <= amount[i] {
                continue
            }
                
            model.stampduty = (money - amount[i]) / 100 * rate[i + 1] + tmpPlus[i]
            break
            }
    }
    
    func ntCalculate() {
        model.regist   = 137
        model.transfer = 137
        
        let amount  = [525000.0,3000000.0]
        let rate    = [0.06571441,4.95,5.45]
        
        let v = amount[0] / 1000.0
        var tmpPlus = [(0.06571441 * v * v) + 15 * v]
        tmpPlus.append(tmpPlus[0] + (amount[1] - amount[0]) * rate[1] / 100)
        
        if (money > amount[1]) {
            model.stampduty = (money - amount[1]) * rate[2] / 100 + tmpPlus[1]
            return
        }
        
        if (money > amount[0]) {
            model.stampduty = (money - amount[0]) * rate[1] / 100 + tmpPlus[0]
            return
        }
        
        let vv = money / 1000.0
        model.stampduty = (rate[0] * vv * vv) + 15 * vv
    }
    
    func qldCalculate() {
        model.regist   = 163
        model.transfer = 157.4 + (money > 180000.0 ? ((money - 180000.0) / 10000.0 * 29.8) : 0)
        
        var amount: [Double]
        var rate: [Double]
        var tmpPlus = [Double]()
        
        // to live
        if(isLive) {
            amount = [350000.0,540000.0,1000000.0]
            rate   = [1.0,3.50,4.50,5.75]
            
            tmpPlus.append(amount[0] * rate[0] / 100)
            tmpPlus.append(tmpPlus[0] + (amount[1] - amount[0]) * rate[1] / 100)
            tmpPlus.append(tmpPlus[1] + (amount[2] - amount[1]) * rate[2] / 100)
        }
        else {
            // not to live
            amount = [5000.0,75000.0,540000.0,1000000.0]
            rate   = [1.50,3.50,4.50,5.75]
            
            tmpPlus.append(0)
            tmpPlus.append((amount[1] - amount[0]) * rate[0] / 100)
            tmpPlus.append(tmpPlus[0] + (amount[2] - amount[1]) * rate[1] / 100)
            tmpPlus.append(tmpPlus[1] + (amount[3] - amount[2]) * rate[2] / 100)
        }
        
        if (money <= amount[0]) {
            model.stampduty = model.isLive ? (money / 100 * rate[0]) : 0
            return
        }
        
        for i in (0..<amount.count).reversed() {
            if (money <= amount[i]) {
                continue
            }
                
            model.stampduty = (money - amount[i]) / 100 * rate[i + (isLive ? 1 : 0)] + tmpPlus[i]
            break
        }
    }
    
    func saCalculate() {
        model.regist = 152
        
        // Transfer fee
        switch money {
        case 0...5000:      model.transfer = 152
        case 5000...20000:  model.transfer = 167
        case 20000...40000: model.transfer = 184
        case 40000...50000: model.transfer = 258
        default:
            let diffValue = money - 50001
            model.transfer = 258 + 75.5 * (diffValue / 10000 + 1)
        }
        
        // stamp duty
        let amount  = [12000.0,30000.0,50000.0,100000.0,200000.0,250000.0,300000.0,500000.0]
        let rate    = [1.0,2.0,3.0,3.50,4.00,4.25,4.75,5.00,5.50]
        var tmpPlus = [amount[0] * rate[0] / 100]
        for i in 1..<amount.count {
            tmpPlus.append(tmpPlus[i - 1] + (amount[i] - amount[i - 1]) * rate[i] / 100)
        }
        
        if (money <= amount[0]) {
            model.stampduty = money / 100 * rate[0]
            return
        }
        
        for i in (0...7).reversed() {
            if (money <= amount[i]) {
                continue
            }
                
            model.stampduty = (money - amount[i]) / 100 * rate[i + 1] + tmpPlus[i]
            break
        }
    }
    
    func tasCalculate() {
        model.regist = 127
        model.transfer = 191.26
        
        let amount = [3000.0,25000.0,75000.0,200000.0,375000.0,725000.0]
        let rate = [1.75,2.25,3.50,4.00,4.25,4.50]
        var tmpPlus = [50.0]
        for i in 1...5 {
            tmpPlus.append(tmpPlus[i - 1] + (amount[i] - amount[i-1]) / 100 * rate[i - 1])
        }
        
        if (money <= amount[0]) {
            model.stampduty = 50
            return
        }
        for i in (0...5).reversed() {
            if (money <= amount[i]) {
                continue
            }
                
            model.stampduty = (money - amount[i]) / 100 * rate[i] + tmpPlus[i]
            break
        }
    }
    
    func vicCalculate() {
        model.regist = 111
        
        model.transfer = min((131 + money / 1000 * 2.46) ,1362)
        
        func noLive(_ _money: Double) -> Double {
            let amount = [25000.0,130000.0,960000.0]
            let rate = [1.4,2.4,6.0,5.5]
            var tmpPlus = [amount[0] * rate[0] / 100]
            tmpPlus.append(tmpPlus[0] + (amount[1] - amount[0]) * rate[1] / 100)
            
            switch _money {
            case 0...amount[0]:         return _money * rate[0] / 100;
            case amount[0]...amount[1]: return (_money - amount[0]) * rate[1] / 100 + tmpPlus[0]
            case amount[1]...amount[2]: return (_money - amount[1]) * rate[2] / 100 + tmpPlus[1]
            default:                    return _money * rate[3] / 100
            }
        }
        
        func live(_ _money: Double) -> Double {
            if (!isLive) {
                return noLive(_money)
            }
            
            let amount = [130000.0,440000.0,550000.0]
            let rate   = [5.0,6.0]
            var tmpPlus = [noLive(amount[0])]
            tmpPlus.append(tmpPlus[0] + (amount[1] - amount[0]) * rate[0] / 100)
            
            switch _money {
            case amount[0]...amount[1]: return (_money - amount[0]) / 100 * rate[0] + tmpPlus[0]
            case amount[1]...amount[2]: return (_money - amount[1]) / 100 * rate[1] + tmpPlus[1]
            default: return noLive(_money)
            }
        }
        
        model.transfer = live(money)
    }
    
    func waCalculate() {
        model.regist   = 160
        model.transfer = 160
        
        let amount  = [80000.0,100000.0,250000.0,500000.0]
        let rate    = [1.90,2.85,3.80,4.75,5.15]
        var tmpPlus = [amount[0] * rate[0] / 100]
        for i in 1..<amount.count {
            tmpPlus.append(tmpPlus[i - 1] + (amount[i] - amount[i - 1]) * rate[i] / 100)
        }
        
        if (money <= amount[0]) {
            model.stampduty = money / 100 * rate[0]
            return
        }
        
        for i in (0..<amount.count).reversed() {
            if (money <= amount[i]) {
                continue
            }
                
            model.stampduty = (money - amount[i]) / 100 * rate[i + 1] + tmpPlus[i]
            break
        }
    }
}
