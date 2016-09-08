//
//  ContactFollowTableViewCell.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/9/5.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

enum ContactUsFollowType: Int {
    case weixin, facebook, weibo, linkedin, twitter
    
    var imageName: String {
        switch self {
        case weixin:    return "ContactUs_weixin"
        case facebook:  return "ContactUs_facebook"
        case weibo:     return "ContactUs_weibo"
        case linkedin:  return "ContactUs_linkedin"
        case twitter:   return "ContactUs_twitter"
        }
    }
    
    var url: NSURL {
        switch self {
        case weixin:    return NSURL()
        case facebook:  return NSURL(string: "https://www.facebook.com/abacus.homeloans?fref=ts")!
        case weibo:     return NSURL(string: "http://weibo.com/abacushomeloans")!
        case linkedin:  return NSURL(string: "http://www.linkedin.com/company/4848470?trk=tyah&trkInfo=tarId%3A1420693136450%2Ctas%3Aabacus%0home%20loan%2Cidx%3A2-1-2")!
        case twitter:   return NSURL(string: "https://twitter.com/abacushl")!
        }
    }
    
    
}

protocol ContactFollowTableViewCellDelegate: NSObjectProtocol {
    func followClicked(type: ContactUsFollowType)
}

class ContactFollowTableViewCell: UITableViewCell {

    // MARK: - Variables
    weak var delegate: ContactFollowTableViewCellDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.textColor     = UIColor.themeGreen()
        label.font          = UIFont.systemFontOfSize(17)
        label.numberOfLines = 2
        label.text = CONTACTUS_TITLE_4()
        
        return label
    }()
    
    private let imageNames: [ContactUsFollowType] = [
        .weixin,
        .facebook,
        .weibo,
        .linkedin,
        .twitter
    ]
    
    // MARK: - Life Cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        
        contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(15)
        }
        
        var tmpButton: UIButton?
        for followType in imageNames {
            let button = UIButton(type: .Custom)
            contentView.addSubview(button)
            
            button.setImage(UIImage(named: followType.imageName), forState: .Normal)
            button.addTarget(self, action: #selector(buttonClicked), forControlEvents: .TouchUpInside)
            button.tag = followType.rawValue
            
            button.snp_makeConstraints(closure: { (make) in
                if (tmpButton == nil) {
                    make.left.equalTo(titleLabel.snp_right).offset(15)
                } else {
                    make.left.equalTo(tmpButton!.snp_right)
                    make.width.equalTo(tmpButton!)
                }
                
                if (followType == imageNames.last) {
                    make.right.equalTo(contentView).offset(-15)
                }
                
                make.centerY.equalTo(contentView)
            })
            
            tmpButton = button
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Responses
    @objc private func buttonClicked(button: UIButton) {
        delegate?.followClicked(ContactUsFollowType(rawValue: button.tag)!)
    }
}
