//
//  CheckListPreTableViewCell.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/7/3.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import UIKit

class CheckListPreTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var describeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CheckListPreTableViewCell {
    func dataWithTitle(title: String, describe: String) {
        titleLabel.text    = title
        describeLabel.text = describe
    }
}
