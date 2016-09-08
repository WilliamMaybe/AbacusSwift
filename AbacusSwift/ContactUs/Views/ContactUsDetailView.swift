//
//  ContactUsDetailView.swift
//  AbacusSwift
//
//  Created by maybe on 16/9/9.
//  Copyright © 2016年 Money. All rights reserved.
//

import UIKit
import MapKit

class ContactUsDetailView: UIView {

    var cEnum: ContactUsDetail? {
        didSet {
            titleLabel.attributedText = cEnum?.title
            phoneButton.label.text    = cEnum?.phone
            addressButton.label.text  = cEnum?.address
            imageView.image           = cEnum?.locationImage
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var phoneButton: ButtonView = {
        return self.createButton {
            $0.imageView.image = UIImage(named: "ContactUs_phone")
            $0.tag = 101
        }
    }()
    
    private lazy var addressButton: ButtonView = {
        return self.createButton {
            $0.imageView.image = UIImage(named: "ContactUs_address")
            $0.tag = 102
        }
    }()
    
    private lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(phoneButton)
        addSubview(addressButton)
        addSubview(imageView)
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.masksToBounds = true
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(5)
        }
        
        phoneButton.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(titleLabel.snp_bottom).offset(5)
            make.height.equalTo(21)
        }
        
        addressButton.snp_makeConstraints { (make) in
            make.top.equalTo(phoneButton.snp_bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(40)
        }
        
        imageView.snp_makeConstraints { (make) in
            make.top.equalTo(addressButton.snp_bottom).offset(5)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ButtonView
    private class ButtonView: UIControl {
        
        private lazy var label: UILabel = {
            let label = UILabel()
            label.font = UIFont.font_hn_light(15)
            label.textColor = UIColor.themeFont()
            label.numberOfLines = 0
            return label
        }()
        
        private lazy var imageView = UIImageView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(imageView)
            addSubview(label)
            
            label.snp_makeConstraints { (make) in
                make.centerY.equalTo(self)
                make.left.equalTo(self).offset(15)
            }
            
            imageView.snp_makeConstraints { (make) in
                make.centerY.equalTo(self)
                make.right.equalTo(self).offset(-13)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}


private extension ContactUsDetailView {
    func createButton(closure: ((ButtonView) -> ())? ) -> ButtonView {
        let button = ButtonView()
        closure?(button)
        button.addTarget(self, action: #selector(buttonClicked), forControlEvents: .TouchUpInside)
        return button
    }
    
    @objc func buttonClicked(button: ButtonView) {
        if button.tag == 101 {

            let url = NSURL(string: "telprompt://\(cEnum?.phone.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))")
            if let trueUrl = url {
                if UIApplication.sharedApplication().canOpenURL(trueUrl) {
                    UIApplication.sharedApplication().openURL(trueUrl)
                }
            }
            
            return
        }
        
        if button.tag == 102 {
            let destPlaceMark = MKPlacemark(coordinate: cEnum!.location, addressDictionary: nil)
            let destMapItem = MKMapItem(placemark: destPlaceMark)
            let currentMapItem = MKMapItem.mapItemForCurrentLocation()
            MKMapItem.openMapsWithItems([currentMapItem, destMapItem], launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
        }
    }
}
