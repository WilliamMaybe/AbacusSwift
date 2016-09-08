//
//  ContactUsQRView.swift
//  AbacusSwift
//
//  Created by maybe on 16/9/5.
//  Copyright © 2016年 Money. All rights reserved.
//

import UIKit

private class ContactUsQRView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        layer.cornerRadius  = 5
        layer.masksToBounds = true
        
        let image = UIImage(named: "weixinQR")
        let imageView = UIImageView(image: image)
        
        let label = UILabel()
        label.text = "華瑞信貸"
        label.textColor = UIColor.themeGreen()
        label.font = UIFont.systemFontOfSize(15)
        
        let seperatorLine = UIView()
        seperatorLine.backgroundColor = UIColor.lightGrayColor()
        
        addSubview(imageView)
        addSubview(seperatorLine)
        addSubview(label)
        
        imageView.snp_makeConstraints { (make) in
            make.top.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
        }
        
        seperatorLine.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(imageView.snp_bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        label.snp_makeConstraints { (make) in
            make.top.equalTo(seperatorLine).offset(5)
            make.bottom.equalTo(self).offset(-5)
            make.left.equalTo(imageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ContactQRAlertView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureTapped))
        addGestureRecognizer(gesture)
        
        let contentView = ContactUsQRView()
        contentView.userInteractionEnabled = false
        addSubview(contentView)
        contentView.snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func showOnView(view: UIView) {
        let alertView = ContactQRAlertView()
        view.addSubview(alertView)
        alertView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    @objc private func gestureTapped() {
        removeFromSuperview()
    }
}
