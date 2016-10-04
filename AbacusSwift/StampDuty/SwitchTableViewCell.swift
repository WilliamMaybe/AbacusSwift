//
//  SwitchTableViewCell.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/11/10.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  带有Switch的Cell

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    fileprivate lazy var aswitch: UISwitch = {
        let lazySwitch = UISwitch()
        lazySwitch.onTintColor = UIColor.themeGreen()
        lazySwitch.addTarget(self, action: #selector(SwitchTableViewCell.clickToSwitch), for: .touchUpInside)
        return lazySwitch
    }()
    
    fileprivate var switchClosure: (() -> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.textColor = UIColor.themeGreen()
        accessoryView = aswitch
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Interface Method
    func switchOn(_ isOn: Bool) {
        aswitch.isOn = isOn
    }
    
    func switchDidClicked(_ clickedClosure: @escaping () -> Void) {
        switchClosure = clickedClosure
    }
    
    // MARK: - Button Click
    @objc fileprivate func clickToSwitch() {
        switchClosure?()
    }

}
