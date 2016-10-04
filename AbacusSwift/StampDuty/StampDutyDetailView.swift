//
//  StampDutyDetailView.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/11/23.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  stampduty详情View

import UIKit
import SafariServices

class StampDutyDetailView: UIView {
    
// MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        addSubview(grantButton)
        grantButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(-30)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-15)
        }
        
        
        addSubview(stampDutyLabel); addSubview(transferLabel); addSubview(registLabel); addSubview(totalLabel)
        stampDutyLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subTitleLabel.snp.bottom)
            make.left.equalTo(subTitleLabel)
        }
        
        transferLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(stampDutyLabel.snp.bottom)
            make.left.height.width.equalTo(stampDutyLabel)
        }
        
        registLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(transferLabel.snp.bottom)
            make.left.height.width.equalTo(stampDutyLabel)
        }
        
        totalLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(registLabel.snp.bottom)
            make.left.height.width.equalTo(stampDutyLabel)
            make.bottom.equalTo(grantButton.snp.top).offset(-25)
        }
        
        addSubview(disclaimerButton)
        disclaimerButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(grantButton)
        }
        
    
        addSubview(stampDutyMoneyLabel); addSubview(transferMoneyLabel); addSubview(registMoneyLabel); addSubview(totalMoneyLabel);
        stampDutyMoneyLabel.snp.makeConstraints( { (make) -> Void in
            make.centerY.equalTo(stampDutyLabel)
            make.right.equalTo(disclaimerButton)
            make.left.greaterThanOrEqualTo(stampDutyLabel.snp.right).offset(10)
        })
        transferMoneyLabel.snp.makeConstraints( { (make) -> Void in
            make.centerY.equalTo(transferLabel)
            make.right.left.equalTo(stampDutyMoneyLabel)
        })
        registMoneyLabel.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(registLabel)
            make.left.right.equalTo(stampDutyMoneyLabel)
        })
        totalMoneyLabel.snp.makeConstraints({ (make) -> Void in
            make.centerY.equalTo(totalLabel)
            make.left.right.equalTo(stampDutyMoneyLabel)
        })
    
        let seperatorContentView: UIView = {
            let view = UIView()
            let seperatorLine = UIView()
            seperatorLine.backgroundColor = UIColor.themeGreen()
            view.addSubview(seperatorLine)
            seperatorLine.snp.makeConstraints { (make) -> Void in
                make.left.right.centerY.equalTo(view)
                make.height.equalTo(1.5)
            }
            return view
        }()
        
        addSubview(seperatorContentView)
        seperatorContentView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(disclaimerButton)
            make.width.equalTo(135)
            make.top.equalTo(registMoneyLabel.snp.bottom)
            make.bottom.equalTo(totalMoneyLabel.snp.top)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Button Click
    @objc fileprivate func clickToDisclaimer() {
        let appDelegate = UIApplication.shared.delegate
        
        let alertVC = UIAlertController(title: nil, message: STAMPDUTY_GRAPH_1_DISCLAIMER_CONTENT(), preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: DONE(), style: .default, handler: nil))
        appDelegate?.window??.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
    
    @objc fileprivate func clickToGrant() {
        let appDelegate = UIApplication.shared.delegate
        
        let url = URL(string:grantURL!)!
        let safariVC = SFSafariViewController(url: url)
        appDelegate?.window??.rootViewController?.present(safariVC, animated: true, completion: nil)
    }
    
// MARK: - Interface Method
    func setData(_ result: stampDutyType) {
        titleLabel.text = result.pickerFullTitle
        
        let dict = [
            NSFontAttributeName:UIFont.font_hn_regular(15)!,
            NSForegroundColorAttributeName:UIColor.themeGreen(),
            NSUnderlineStyleAttributeName:NSUnderlineStyle.styleSingle .rawValue
        ] as [String : Any]
        
        let grant = NSMutableAttributedString(string: STAMPDUTY_GRAPH_1_CONCESSION() + "\n" + result.url, attributes: dict)
        
        let range = NSMakeRange(0, STAMPDUTY_GRAPH_1_CONCESSION().characters.count)
        grant.addAttribute(NSFontAttributeName, value: UIFont.font_hn_regular(13)!, range: range)
        grantButton.setAttributedTitle(grant, for: UIControlState())
        
        stampDutyMoneyLabel.text = result.stampduty.moneyFormatter()
        transferMoneyLabel.text  = result.transfer.moneyFormatter()
        registMoneyLabel.text    = result.regist.moneyFormatter()
        totalMoneyLabel.text     = result.total.moneyFormatter()
    }
    
// MARK: - Private Method
    fileprivate func createLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.font_hn_bold(20)
        label.textColor = UIColor.themeGreen()
        label.text = title
        return label
    }
    
    fileprivate func createMoneyLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.font_hn_medium(24)
        label.textColor = UIColor.themeGreen()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }
// MARK: - Initializer
    fileprivate lazy var titleLabel: UILabel = {
        let lazyLabel = UILabel()
        lazyLabel.font = UIFont.font_hn_ultralight(21)
        lazyLabel.textColor = UIColor.themeGreen()
        return lazyLabel
    }()
    
    fileprivate lazy var disclaimerButton: UIButton = {
        let lazyButton = UIButton()
        let attriString = NSAttributedString(
            string: STAMPDUTY_GRAPH_1_DISCLAIMER(),
            attributes: [
                NSFontAttributeName:UIFont.font_hn_light(12)!,
                NSForegroundColorAttributeName:UIColor.themeGreen(),
                NSUnderlineStyleAttributeName:NSUnderlineStyle.styleSingle.rawValue
            ])
        lazyButton.setAttributedTitle(attriString, for: UIControlState())
        lazyButton.addTarget(self, action: #selector(StampDutyDetailView.clickToDisclaimer), for: .touchUpInside)
        return lazyButton
    }()
    
    fileprivate lazy var subTitleLabel: UILabel = {
        let lazyLabel = UILabel()
        lazyLabel.font = UIFont.font_hn_bold(12)
        lazyLabel.textColor = UIColor.themeGreen()
        lazyLabel.text = STAMPDUTY_GRAPH_1_SUBTITLE()
        return lazyLabel
    }()
    
    fileprivate lazy var grantButton: UIButton = {
        let lazyButton = UIButton()
        lazyButton.titleLabel?.numberOfLines = 0
        lazyButton.addTarget(self, action: #selector(StampDutyDetailView.clickToGrant), for: .touchUpInside)
        return lazyButton
    }()
    
    fileprivate lazy var stampDutyLabel: UILabel = self.createLabel(STAMPDUTY_GRAPH_1_STAMPDUTY())
    fileprivate lazy var transferLabel: UILabel  = self.createLabel(STAMPDUTY_GRAPH_1_TRANSFERFEE())
    fileprivate lazy var registLabel: UILabel    = self.createLabel(STAMPDUTY_GRAPH_1_REGISTRATION())
    fileprivate lazy var totalLabel: UILabel     = self.createLabel(STAMPDUTY_GRAPH_1_TOTAL())
    
    fileprivate lazy var stampDutyMoneyLabel: UILabel = self.createMoneyLabel()
    fileprivate lazy var transferMoneyLabel: UILabel  = self.createMoneyLabel()
    fileprivate lazy var registMoneyLabel: UILabel    = self.createMoneyLabel()
    fileprivate lazy var totalMoneyLabel: UILabel     = self.createMoneyLabel()
    
    fileprivate var grantURL: String?
}
