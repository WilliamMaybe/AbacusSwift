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
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(10 + marginYFrom320() / 2)
        }
        
        addSubview(subTitleLabel)
        subTitleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(12)
        }
        
        addSubview(grantButton)
        grantButton.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(-30)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-15)
        }
        
        (
            addSubview(stampDutyLabel),addSubview(transferLabel),addSubview(registLabel),addSubview(totalLabel),
            stampDutyLabel.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(subTitleLabel.snp_bottom)
                make.left.equalTo(subTitleLabel)
            },
            transferLabel.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(stampDutyLabel.snp_bottom)
                make.left.height.width.equalTo(stampDutyLabel)
            },
            registLabel.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(transferLabel.snp_bottom)
                make.left.height.width.equalTo(stampDutyLabel)
            },
            totalLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(registLabel.snp_bottom)
                make.left.height.width.equalTo(stampDutyLabel)
                make.bottom.equalTo(grantButton.snp_top).offset(-25)
            })
        )
        
        addSubview(disclaimerButton)
        disclaimerButton.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(grantButton)
        }
        
        (
            addSubview(stampDutyMoneyLabel),addSubview(transferMoneyLabel),addSubview(registMoneyLabel),addSubview(totalMoneyLabel),
            stampDutyMoneyLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(stampDutyLabel)
                make.right.equalTo(disclaimerButton)
                make.left.greaterThanOrEqualTo(stampDutyLabel.snp_right).offset(10)
            }),
            transferMoneyLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(transferLabel)
                make.right.left.equalTo(stampDutyMoneyLabel)
            }),
            registMoneyLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(registLabel)
                make.left.right.equalTo(stampDutyMoneyLabel)
            }),
            totalMoneyLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(totalLabel)
                make.left.right.equalTo(stampDutyMoneyLabel)
            })
        )
    
        let seperatorContentView: UIView = {
            let view = UIView()
            let seperatorLine = UIView()
            seperatorLine.backgroundColor = UIColor.themeGreen()
            view.addSubview(seperatorLine)
            seperatorLine.snp_makeConstraints { (make) -> Void in
                make.left.right.centerY.equalTo(view)
                make.height.equalTo(1.5)
            }
            return view
        }()
        
        addSubview(seperatorContentView)
        seperatorContentView.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(disclaimerButton)
            make.width.equalTo(135)
            make.top.equalTo(registMoneyLabel.snp_bottom)
            make.bottom.equalTo(totalMoneyLabel.snp_top)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Button Click
    @objc private func clickToDisclaimer() {
        let appDelegate = UIApplication.sharedApplication().delegate
        
        let alertVC = UIAlertController(title: nil, message: localStringFromKey(STAMPDUTY_GRAPH_1_DISCLAIMER_CONTENT), preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: localStringFromKey(DONE), style: .Default, handler: nil))
        appDelegate?.window??.rootViewController?.presentViewController(alertVC, animated: true, completion: nil)
    }
    
    @objc private func clickToGrant() {
        let appDelegate = UIApplication.sharedApplication().delegate
        
        let url = NSURL(string:grantURL!)!
        let safariVC = SFSafariViewController(URL: url)
        appDelegate?.window??.rootViewController?.presentViewController(safariVC, animated: true, completion: nil)
    }
    
// MARK: - Interface Method
    func setDataWithModel(result: stampDutyResultModel) {
        titleLabel.text = result.fullStateName
        
        let dict = [
            NSFontAttributeName:UIFont.font_hn_regular(15)!,
            NSForegroundColorAttributeName:UIColor.themeGreen(),
            NSUnderlineStyleAttributeName:NSUnderlineStyle.StyleSingle .rawValue
        ]
        
        grantURL = stampDutyURL[result.type.rawValue]
        let grant = NSMutableAttributedString(string: localStringFromKey(STAMPDUTY_GRAPH_1_CONCESSION) + "\n" + grantURL!, attributes: dict)
        
        let range = NSMakeRange(0, localStringFromKey(STAMPDUTY_GRAPH_1_CONCESSION).characters.count)
        grant.addAttribute(NSFontAttributeName, value: UIFont.font_hn_regular(13)!, range: range)
        grantButton.setAttributedTitle(grant, forState: .Normal)
        
        stampDutyMoneyLabel.text = formatterMoney(result.stampduty)
        transferMoneyLabel.text  = formatterMoney(result.transfer)
        registMoneyLabel.text    = formatterMoney(result.regist)
        totalMoneyLabel.text     = formatterMoney(result.total)
    }
    
// MARK: - Private Method
    private func createLabel(title: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.font_hn_bold(20)
        label.textColor = UIColor.themeGreen()
        label.text = title
        return label
    }
    
    private func createMoneyLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.font_hn_medium(24)
        label.textColor = UIColor.themeGreen()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .Right
        return label
    }
// MARK: - Initializer
    private lazy var titleLabel: UILabel = {
        let lazyLabel = UILabel()
        lazyLabel.font = UIFont.font_hn_ultralight(21)
        lazyLabel.textColor = UIColor.themeGreen()
        return lazyLabel
    }()
    
    private lazy var disclaimerButton: UIButton = {
        let lazyButton = UIButton()
        let attriString = NSAttributedString(
            string: localStringFromKey(STAMPDUTY_GRAPH_1_DISCLAIMER),
            attributes: [
                NSFontAttributeName:UIFont.font_hn_light(12)!,
                NSForegroundColorAttributeName:UIColor.themeGreen(),
                NSUnderlineStyleAttributeName:NSUnderlineStyle.StyleSingle.rawValue
            ])
        lazyButton.setAttributedTitle(attriString, forState: .Normal)
        lazyButton.addTarget(self, action: #selector(StampDutyDetailView.clickToDisclaimer), forControlEvents: .TouchUpInside)
        return lazyButton
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let lazyLabel = UILabel()
        lazyLabel.font = UIFont.font_hn_bold(12)
        lazyLabel.textColor = UIColor.themeGreen()
        lazyLabel.text = localStringFromKey(STAMPDUTY_GRAPH_1_SUBTITLE)
        return lazyLabel
    }()
    
    private lazy var grantButton: UIButton = {
        let lazyButton = UIButton()
        lazyButton.titleLabel?.numberOfLines = 0
        lazyButton.addTarget(self, action: #selector(StampDutyDetailView.clickToGrant), forControlEvents: .TouchUpInside)
        return lazyButton
    }()
    
    private lazy var stampDutyLabel: UILabel = self.createLabel(localStringFromKey(STAMPDUTY_GRAPH_1_STAMPDUTY))
    private lazy var transferLabel: UILabel  = self.createLabel(localStringFromKey(STAMPDUTY_GRAPH_1_TRANSFERFEE))
    private lazy var registLabel: UILabel    = self.createLabel(localStringFromKey(STAMPDUTY_GRAPH_1_REGISTRATION))
    private lazy var totalLabel: UILabel     = self.createLabel(localStringFromKey(STAMPDUTY_GRAPH_1_TOTAL))
    
    private lazy var stampDutyMoneyLabel: UILabel = self.createMoneyLabel()
    private lazy var transferMoneyLabel: UILabel  = self.createMoneyLabel()
    private lazy var registMoneyLabel: UILabel    = self.createMoneyLabel()
    private lazy var totalMoneyLabel: UILabel     = self.createMoneyLabel()
    
    private var grantURL: String?
}
