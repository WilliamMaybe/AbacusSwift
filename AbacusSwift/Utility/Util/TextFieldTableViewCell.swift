//
//  TextFieldTableViewCell.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 15/11/8.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  带有输入金钱的textField

import UIKit

public enum TextFieldCellMode {
    case money
    case rate
    case term
}

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    var mode = TextFieldCellMode.money
    
    lazy var titleLabel: UILabel = {
       let lazyLabel = UILabel()
        lazyLabel.textColor = UIColor.themeGreen()
        lazyLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .vertical)
        return lazyLabel
    }()
    
    fileprivate lazy var textField: UITextField = {
        let lazyTextField = UITextField()
        lazyTextField.textColor = UIColor.themeGreen()
        lazyTextField.font = UIFont.font_hn_light(17)
        lazyTextField.textAlignment = .right
        lazyTextField.keyboardType = .numberPad
        lazyTextField.delegate = self
        lazyTextField.clearButtonMode = .whileEditing
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 40))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: lazyTextField, action: #selector(UIResponder.resignFirstResponder))
        doneButton.tintColor = UIColor.themeGreen()
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        lazyTextField.inputAccessoryView = toolBar
        
        return lazyTextField
    }()
    
    fileprivate var finishedClosure :((Double)->Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(15)
        }
        
        contentView.addSubview(textField)
        textField.snp.makeConstraints { (make) -> Void in
            make.top.bottom.right.equalTo(contentView)
            make.left.equalTo(titleLabel.snp.right).offset(10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Interface Method
    func textFinished(_ finished: @escaping (Double)->Void) {
        finishedClosure = finished
    }
    
    func setTextFieldText(_ text: String) {
        textField.text = text
    }
    
// MARK: - UITextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if mode != .money {
            return true
        }
        
        var nsString = textField.text! as NSString
        nsString = nsString.replacingCharacters(in: range, with: string) as NSString
        
        var finalString = String(nsString)
        
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
        
        finalString = finalString.substring(from: finalString.characters.index(finalString.startIndex, offsetBy: 1))
        finalString = finalString.replacingOccurrences(of: ",", with: "")
        
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en-AU")
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .down
        
        let number = NSNumber(value: Int64(finalString) ?? 0 as Int64)
        finalString = numberFormatter.string(from: number)!
        
        textField.text = "$" + finalString
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var data: Double = 0
        let text = textField.text ?? ""

        switch mode {
        case .money:
            if text.characters.count == 0 {
                textField.text = "$0"
            } else {
                let tmp = (text as NSString).substring(from: 1)
                data = Double(tmp.replacingOccurrences(of: ",", with: "")) ?? 0
            }
        case .rate:
            data = Double(text) ?? 0
            textField.text = "\(String.localizedStringWithFormat("%.2lf", data))%"
            data = data / 100
        case .term:
            data = Double(text) ?? 0
            textField.text = "\(Int(data)) \(YEARS())"
        }
        
        finishedClosure?(data)
    }
}
