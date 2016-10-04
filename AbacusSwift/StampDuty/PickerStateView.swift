//
//  PickerStateView.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/11/10.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  选择洲View

import UIKit

class PickerStateView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    fileprivate lazy var pickerView: UIPickerView = {
        let lazyPickerView = UIPickerView()
        lazyPickerView.delegate   = self
        lazyPickerView.dataSource = self
        return lazyPickerView
    }()
    
    fileprivate lazy var toolBar: UIToolbar = {
        let lazyToolBar = UIToolbar()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PickerStateView.clickToDone))
        doneButton.tintColor = UIColor.themeGreen()
        
        lazyToolBar.setItems([flexible ,doneButton], animated: false)

        return lazyToolBar
    }()
    
    let pickerArray: [stampDutyType]
    fileprivate var selectedClosure: ((Int) -> Void)?
    
// MARK: - Life Cycle
    init(pickers: [stampDutyType]) {
        self.pickerArray = pickers
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.white
        
        addSubview(toolBar)
        addSubview(pickerView)
        toolBar.snp.makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.height.equalTo(40)
        }
        
        pickerView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(toolBar.snp.bottom)
            make.height.equalTo(216)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Interface Method
    func selectedIndex(_ selectClosure: @escaping (_ index :Int) -> Void) {
        selectedClosure = selectClosure
    }

// MARK: - Button Click
    @objc fileprivate func clickToDone() {
        selectedClosure?(pickerView.selectedRow(inComponent: 0))
    }
    
// MARK: - UIPickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row].pickerFullTitle
    }
}
