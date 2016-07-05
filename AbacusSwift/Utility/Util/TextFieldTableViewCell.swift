//
//  TextFieldTableViewCell.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/11/8.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  带有输入金钱的textField

import UIKit

public enum TextFieldCellMode: Int {
    case money = 0
    case rate
    case term
}

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    class func identifier() -> String {
        return NSStringFromClass(self)
    }
    
    var mode: TextFieldCellMode?
    
    lazy var titleLabel: UILabel = {
       let lazyLabel = UILabel()
        lazyLabel.textColor = UIColor.themeGreen()
        lazyLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
        return lazyLabel
    }()
    
    private lazy var textField: UITextField = {
        let lazyTextField = UITextField()
        lazyTextField.textColor = UIColor.themeGreen()
        lazyTextField.font = UIFont.font_hn_light(17)
        lazyTextField.textAlignment = .Right
        lazyTextField.keyboardType = .NumberPad
        lazyTextField.delegate = self
        lazyTextField.clearButtonMode = .WhileEditing
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(self.frame), height: 40))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: lazyTextField, action: #selector(UIResponder.resignFirstResponder))
        doneButton.tintColor = UIColor.themeGreen()
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil), doneButton]
        
        lazyTextField.inputAccessoryView = toolBar
        
        return lazyTextField
    }()
    
    private var finishedClosure :((Double)->Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        accessoryType = .DisclosureIndicator
        
        contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(15)
        }
        
        contentView.addSubview(textField)
        textField.snp_makeConstraints { (make) -> Void in
            make.top.bottom.right.equalTo(contentView)
            make.left.equalTo(titleLabel.snp_right).offset(10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Interface Method
    func textFinished(finished: (Double)->Void) {
        finishedClosure = finished
    }
    
    func setTextFieldText(text: String) {
        textField.text = text
    }
    
// MARK: - UITextField Delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if TextFieldCellMode(rawValue: tag) != .money {
            return true
        }
        
        var finalString = textField.text!
        
        if let swRange = finalString.rangeFromNSRange(range) {
            finalString = finalString.stringByReplacingCharactersInRange(swRange, withString: string)
        }
        
        if finalString == "" {
            return false
        }
        
        if finalString.characters.count == 1 {
            if finalString == "$" {
                textField.text = ""
                return false
            }
            finalString = "$" + finalString
        }
        
        finalString = finalString.substringFromIndex(finalString.startIndex.advancedBy(1))
        finalString = finalString.stringByReplacingOccurrencesOfString(",", withString: "")
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.locale = NSLocale(localeIdentifier: "en-AU")
        numberFormatter.numberStyle = .DecimalStyle
        numberFormatter.roundingMode = .RoundDown
        
        let number = NSNumber(longLong: Int64(finalString) ?? 0)
        finalString = numberFormatter.stringFromNumber(number)!
        
        textField.text = "$"+finalString
        
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        var data: Double = 0
        let text = textField.text ?? ""

        switch TextFieldCellMode(rawValue: tag)! {
        case .money:
            if text.characters.count == 0 {
                textField.text = "$0"
            } else {
                let tmp = (text as NSString).substringFromIndex(1)
                data = Double(tmp.stringByReplacingOccurrencesOfString(",", withString: "")) ?? 0
            }
        case .rate:
            data = Double(text) ?? 0
            textField.text = "\(String.localizedStringWithFormat("%.2lf", data))%"
            data = data / 100
        case .term:
            data = Double(text) ?? 0
            textField.text = "\(Int(data)) \(localStringFromKey(YEARS)))"
        }
        
        finishedClosure?(data)
    }
}
