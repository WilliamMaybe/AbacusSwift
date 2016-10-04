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
    
    let lineCount: Int
    
// MARK: - Life Cycle
    init(lineCount: Int) {
        self.lineCount = lineCount
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.themeGray()
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(10 + marginYFrom320() / 2)
        }
        
        addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        
        var lastView: UIView?
        for _ in 0..<lineCount {
            let perLine = stampDutyPerLine()
            addSubview(perLine)
            lineArray.append(perLine)
            
            perLine.snp.makeConstraints({ (make) -> Void in
                make.left.equalTo(self)
                make.right.equalTo(self).offset(-13)
                if lastView == nil {
                    make.top.equalTo(subTitleLabel.snp.bottom)
                } else {
                    make.top.equalTo(lastView!.snp.bottom)
                    make.height.equalTo(lastView!)
                }
            })
            
            lastView = perLine
        }
        
        lastView?.snp.makeConstraints({ (make) -> Void in
            make.bottom.equalTo(self).offset(-10)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Initializer
    fileprivate lazy var subTitleLabel: UILabel = {
        let lazyLabel = UILabel()
        lazyLabel.font = UIFont.font_hn_bold(12)
        lazyLabel.textColor = UIColor.themeGreen()
        lazyLabel.text = STAMPDUTY_GRAPH_2_SUBTITLE()
        return lazyLabel
    }()
    
    fileprivate lazy var lineArray: [stampDutyPerLine] = [stampDutyPerLine]()
}

// MARK: - Interface Method
extension StampDutyComparisonView {
    func setDatas(_ datas: [stampDutyType], selectedAtIndex: Int) {
        titleLabel.text = datas[selectedAtIndex].pickerFullTitle
        
        let maxData = datas.max { $0.total < $1.total } as stampDutyType!
        
        for i in 0..<datas.count {
            let line = lineArray[i]
            let data = datas[i]
            
            line.lineColor((i == selectedAtIndex) ? UIColor.themeYellow() : UIColor.themeGreen())
            line.setData(data, biggest: (maxData?.total)!)
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
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(70)
        }
        
        moneyLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.centerY.equalTo(titleLabel)
            make.width.equalTo(70)
        }
        contentView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(moneyLabel.snp.right).offset(15)
            make.height.equalTo(16)
            make.centerY.equalTo(self)
            make.right.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Interface Method
    func setData(_ result: stampDutyType, biggest: Double) {
        titleLabel.text = result.pickerTitle
        moneyLabel.text = result.total.moneyFormatter()
        
        lineView.snp.remakeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(contentView)
            make.width.equalTo(contentView).multipliedBy(result.total / biggest)
        }
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.layoutIfNeeded()
        }) 
    }
    
    func lineColor(_ color: UIColor) {
        lineView.backgroundColor = color
    }
    
// MARK: - Initializer
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font_hn_light(14)
        label.textColor = UIColor.themeGreen()
        return label
    }()
    
    fileprivate lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font_hn_bold(17)
        label.textColor = UIColor.themeGreen()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate lazy var contentView: UIView = UIView()
    
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.themeGreen()
        
        return view
    }()
    
}
