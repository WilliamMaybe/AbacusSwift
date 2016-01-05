//
//  StampDutyComparisonView.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/12/29.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  stampduty价格比较View

import UIKit

class StampDutyComparisonView: UIView {

    lazy var titleLabel: UILabel = {
        let lazyLabel = UILabel()
        lazyLabel.font = UIFont.font_hn_ultralight(21)
        lazyLabel.textColor = UIColor.themeGreen()
        return lazyLabel
    }()
    
// MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.themeGray()
        
        addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(10 + marginYFrom320() / 2)
        }
        
        addSubview(subTitleLabel)
        subTitleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(12)
        }
        
        var lastView:UIView?
        for i in 0..<stampDutyPickerCount {
            let perLine = stampDutyPerLine()
            perLine.tag = i
            addSubview(perLine)
            lineArray.append(perLine)
            
            perLine.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self)
                make.right.equalTo(self).offset(-13)
                if lastView == nil {
                    make.top.equalTo(subTitleLabel.snp_bottom)
                } else {
                    make.top.equalTo(lastView!.snp_bottom)
                    make.height.equalTo(lastView!)
                }
            })
            
            lastView = perLine
        }
        
        lastView?.snp_updateConstraints(closure: { (make) -> Void in
            make.bottom.equalTo(self).offset(-10)
        })
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Initializer
    private lazy var subTitleLabel: UILabel = {
        let lazyLabel = UILabel()
        lazyLabel.font = UIFont.font_hn_bold(12)
        lazyLabel.textColor = UIColor.themeGreen()
        lazyLabel.text = localStringFromKey(STAMPDUTY_GRAPH_2_SUBTITLE)
        return lazyLabel
    }()
    
    private lazy var lineArray: [stampDutyPerLine] = [stampDutyPerLine]()
    /// 初始值
    private var initialModel: stampDutyModel?
}

// MARK: - Interface Method
extension StampDutyComparisonView {
    func setDataWithModel(initialModel: stampDutyModel) {
        titleLabel.text = initialModel.fullStateName
        self.initialModel = initialModel
        
        // 计算出每个的价值
        let resultArray = lineArray.map { (line) -> stampDutyResultModel in
            let tag = line.tag
            let model = stampDutyModel()
            model.type = stampDutyType(rawValue: tag)!
            model.money = initialModel.money
            model.isLive = initialModel.isLive
            model.isFirstBuy = initialModel.isFirstBuy
            
            line.lineColor((tag == initialModel.type.rawValue) ? UIColor.themeYellow() : UIColor.themeGreen())
            
            return handleMoney(model)
        }
        
        let maxTotalModel = resultArray.maxElement { $0.total < $1.total}!
        for line in lineArray {
            line.setData(resultArray[line.tag], biggest: maxTotalModel.total)
        }
    }
}

// MARK: -
// MARK: - 每一行单独View
private class stampDutyPerLine: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(moneyLabel)
        addSubview(contentView)
        contentView.addSubview(lineView)
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(70)
        }
        
        moneyLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel.snp_right).offset(10)
            make.centerY.equalTo(titleLabel)
            make.width.equalTo(70)
        }
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(moneyLabel.snp_right).offset(15)
            make.height.equalTo(16)
            make.centerY.equalTo(self)
            make.right.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Interface Method
    func setData(resultModel: stampDutyResultModel, biggest: Double) {
        titleLabel.text = resultModel.stateName
        moneyLabel.text = formatterMoney(resultModel.total)
        
        lineView.snp_remakeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(contentView)
            make.width.equalTo(contentView).multipliedBy(resultModel.total / biggest)
        }
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.layoutIfNeeded()
        }
    }
    
    func lineColor(color: UIColor) {
        lineView.backgroundColor = color
    }
    
// MARK: - Initializer
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font_hn_light(14)
        label.textColor = UIColor.themeGreen()
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font_hn_bold(17)
        label.textColor = UIColor.themeGreen()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.themeGreen()
        
        return view
    }()
    
}
