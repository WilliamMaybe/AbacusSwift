//
//  PickerStateView.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/11/10.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  选择洲View

import UIKit

class PickerStateView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private lazy var pickerView: UIPickerView = {
        let lazyPickerView = UIPickerView()
        lazyPickerView.delegate   = self
        lazyPickerView.dataSource = self
        return lazyPickerView
    }()
    
    private lazy var toolBar: UIToolbar = {
        let lazyToolBar = UIToolbar()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(PickerStateView.clickToDone))
        doneButton.tintColor = UIColor.themeGreen()
        
        lazyToolBar.setItems([flexible ,doneButton], animated: false)

        return lazyToolBar
    }()
    
    private lazy var pickerArray: [String] = []
    private var selectedClosure: ((Int) -> Void)?
    
// MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for i in 1...stampDutyPickerCount {
            pickerArray.append(stampDutyPickerTitle(i))
        }
        
        backgroundColor = UIColor.whiteColor()
        
        addSubview(toolBar)
        addSubview(pickerView)
        toolBar.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.height.equalTo(40)
        }
        
        pickerView.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(toolBar.snp_bottom)
            make.height.equalTo(216)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Interface Method
    func selectedIndex(selectClosure: (index :Int) -> Void) {
        selectedClosure = selectClosure
    }

// MARK: - Button Click
    @objc private func clickToDone() {
        selectedClosure?(pickerView.selectedRowInComponent(0))
    }
    
// MARK: - UIPickerView Delegate & DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
}
