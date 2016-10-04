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
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    fileprivate lazy var phoneButton: ButtonView = {
        return self.createButton {
            $0.imageView.image = UIImage(named: "ContactUs_phone")
            $0.tag = 101
        }
    }()
    
    fileprivate lazy var addressButton: ButtonView = {
        return self.createButton {
            $0.imageView.image = UIImage(named: "ContactUs_address")
            $0.tag = 102
        }
    }()
    
    fileprivate lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(phoneButton)
        addSubview(addressButton)
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(5)
        }
        
        phoneButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.height.equalTo(21)
        }
        
        addressButton.snp.makeConstraints { (make) in
            make.top.equalTo(phoneButton.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(40)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(addressButton.snp.bottom).offset(5)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ButtonView
    fileprivate class ButtonView: UIControl {
        
        fileprivate lazy var label: UILabel = {
            let label = UILabel()
            label.font = UIFont.font_hn_light(15)
            label.textColor = UIColor.themeFont()
            label.numberOfLines = 0
            return label
        }()
        
        fileprivate lazy var imageView = UIImageView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(imageView)
            addSubview(label)
            
            label.snp.makeConstraints { (make) in
                make.centerY.equalTo(self)
                make.left.equalTo(self).offset(15)
            }
            
            imageView.snp.makeConstraints { (make) in
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
    func createButton(_ closure: ((ButtonView) -> ())? ) -> ButtonView {
        let button = ButtonView()
        closure?(button)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }
    
    @objc func buttonClicked(_ button: ButtonView) {
        if button.tag == 101 {

            let url = URL(string: "telprompt://\(cEnum?.phone.trimmingCharacters(in: CharacterSet.whitespaces))")
            if let trueUrl = url {
                if UIApplication.shared.canOpenURL(trueUrl) {
                    UIApplication.shared.openURL(trueUrl)
                }
            }
            
            return
        }
        
        if button.tag == 102 {
            let destPlaceMark = MKPlacemark(coordinate: cEnum!.location, addressDictionary: nil)
            let destMapItem = MKMapItem(placemark: destPlaceMark)
            let currentMapItem = MKMapItem.forCurrentLocation()
            MKMapItem.openMaps(with: [currentMapItem, destMapItem], launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
        }
    }
}
