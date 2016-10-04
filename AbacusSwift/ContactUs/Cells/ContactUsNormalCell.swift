//
//  ContactUsNormalCell.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/9/4.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

class ContactUsNormalCell: UITableViewCell {
    
    // MARK: - variables
    fileprivate(set) lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font      = UIFont.font_hn_light(15)
        label.textColor = UIColor.themeFont()
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = UIFont.systemFont(ofSize: 17)
        textLabel?.textColor = UIColor.themeGreen()
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(65)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
