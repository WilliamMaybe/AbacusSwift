//
//  CheckListHeaderView.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/3/2.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

class CheckListHeaderView: UITableViewHeaderFooterView {
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.themeGreen()
        label.font = UIFont.font_hn_light(15)
        label.numberOfLines = 0
        
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor.color(w: 226)
        contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
