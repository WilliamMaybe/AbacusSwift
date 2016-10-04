//
//  ContactUsFooter.swift
//  AbacusSwift
//
//  Created by maybe on 16/9/5.
//  Copyright © 2016年 Money. All rights reserved.
//

import UIKit
import MapKit

enum ContactUsDetail {
    case sydney
    case melbourne
    case canberra
    
    var title: NSAttributedString {
        
        var tmp: String
        
        switch self {
        case .sydney:    tmp = CONTACTUS_MAP_TITLE_1()
        case .melbourne: tmp = CONTACTUS_MAP_TITLE_2()
        case .canberra:  tmp = CONTACTUS_MAP_TITLE_3()
        }
        
        let attributeString = NSMutableAttributedString(string: tmp,
                                                        attributes: [
                                                            NSFontAttributeName : UIFont.systemFont(ofSize: 17),
                                                            NSForegroundColorAttributeName : UIColor.themeGreen()
            ])
        if InternationalControl.checkIfIsEnglish() {
            return attributeString
        }
        
        let range = NSRange(location: 4,length: tmp.characters.count - 6)
        attributeString.addAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17)], range: range)
        return attributeString
    }
    
    var phone: String {
        switch self {
        case .sydney:       return CONTACTUS_MAP_PHONE_1()
        case .melbourne:    return CONTACTUS_MAP_PHONE_2()
        case .canberra:     return CONTACTUS_MAP_PHONE_3()
        }
    }
    
    var address: String {
        switch self {
        case .sydney:       return CONTACTUS_MAP_ADDRESS_1()
        case .melbourne:    return CONTACTUS_MAP_ADDRESS_2()
        case .canberra:     return CONTACTUS_MAP_ADDRESS_3()
        }
    }
    
    var location: CLLocationCoordinate2D {
        switch self {
        case .sydney:       return CLLocationCoordinate2D(latitude: -33.8796622000, longitude: 151.2067816000)
        case .melbourne:    return CLLocationCoordinate2D(latitude: -37.8141070000, longitude: 144.9604100000)
        case .canberra:     return CLLocationCoordinate2D(latitude: -35.2502890000, longitude: 149.1393820000)
        }
    }
    
    var locationImage: UIImage? {
        switch self {
        case .sydney:       return UIImage(named: "contactus_Map_Sydney")
        case .melbourne:    return UIImage(named: "contactus_Map_Melbourne")
        case .canberra:     return UIImage(named: "contactus_Map_Canberra")
        }
    }
}

class ContactUsFooter: UIView {

    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator   = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        return scrollView
    }()
    
    fileprivate let pageControl = PageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        let contactEnums: [ContactUsDetail] = [.sydney, .melbourne, .canberra]
        
        pageControl.numberOfPages = contactEnums.count
        
        addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-15)
        }
        
        var tmpView: UIView?
        for cEnum in contactEnums {
            let view = ContactUsDetailView()
            view.cEnum = cEnum
            scrollView.addSubview(view)
            
            view.snp.makeConstraints( { (make) in
                make.top.bottom.width.equalTo(self)
                if let existView = tmpView {
                    make.left.equalTo(existView.snp.right)
                } else {
                    make.left.equalTo(scrollView)
                }
            })
            
            tmpView = view
        }
        
        tmpView!.snp.makeConstraints { (make) in
            make.right.equalTo(scrollView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIScrollViewDelegate
extension ContactUsFooter: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = (scrollView.contentOffset.x - frame.width * 0.5) / frame.width + 1
        pageControl.currentPage = Int(currentPage)
    }
}
