//
//  SwitchTableViewCell.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/11/10.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  带有Switch的Cell

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    private lazy var aswitch: UISwitch = {
        let lazySwitch = UISwitch()
        lazySwitch.onTintColor = UIColor.themeGreen()
        lazySwitch.addTarget(self, action: #selector(SwitchTableViewCell.clickToSwitch), forControlEvents: .TouchUpInside)
        return lazySwitch
    }()
    
    private var switchClosure: (() -> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.textColor = UIColor.themeGreen()
        accessoryView = aswitch
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Interface Method
    func switchOn(isOn: Bool) {
        aswitch.on = isOn
    }
    
    func switchDidClicked(clickedClosure: () -> Void) {
        switchClosure = clickedClosure
    }
    
    // MARK: - Button Click
    @objc private func clickToSwitch() {
        switchClosure?()
    }

}
