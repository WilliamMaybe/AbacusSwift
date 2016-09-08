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
    case Sydney
    case Melbourne
    case Canberra
    
    var title: NSAttributedString {
        
        var tmp: String
        
        switch self {
        case .Sydney:    tmp = CONTACTUS_MAP_TITLE_1()
        case .Melbourne: tmp = CONTACTUS_MAP_TITLE_2()
        case .Canberra:  tmp = CONTACTUS_MAP_TITLE_3()
        }
        
        let attributeString = NSMutableAttributedString(string: tmp,
                                                        attributes: [
                                                            NSFontAttributeName : UIFont.systemFontOfSize(17),
                                                            NSForegroundColorAttributeName : UIColor.themeGreen()
            ])
        if InternationalControl.checkIfIsEnglish() {
            return attributeString
        }
        
        let range = NSRange(location: 4,length: tmp.characters.count - 6)
        attributeString.addAttributes([NSFontAttributeName : UIFont.boldSystemFontOfSize(17)], range: range)
        return attributeString
    }
    
    var phone: String {
        switch self {
        case .Sydney:       return CONTACTUS_MAP_PHONE_1()
        case .Melbourne:    return CONTACTUS_MAP_PHONE_2()
        case .Canberra:     return CONTACTUS_MAP_PHONE_3()
        }
    }
    
    var address: String {
        switch self {
        case .Sydney:       return CONTACTUS_MAP_ADDRESS_1()
        case .Melbourne:    return CONTACTUS_MAP_ADDRESS_2()
        case .Canberra:     return CONTACTUS_MAP_ADDRESS_3()
        }
    }
    
    var location: CLLocationCoordinate2D {
        switch self {
        case .Sydney:       return CLLocationCoordinate2D(latitude: -33.8796622000, longitude: 151.2067816000)
        case .Melbourne:    return CLLocationCoordinate2D(latitude: -37.8141070000, longitude: 144.9604100000)
        case .Canberra:     return CLLocationCoordinate2D(latitude: -35.2502890000, longitude: 149.1393820000)
        }
    }
    
    var locationImage: UIImage? {
        switch self {
        case .Sydney:       return UIImage(named: "contactus_Map_Sydney")
        case .Melbourne:    return UIImage(named: "contactus_Map_Melbourne")
        case .Canberra:     return UIImage(named: "contactus_Map_Canberra")
        }
    }
}

class ContactUsFooter: UIView {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.pagingEnabled = true
        scrollView.showsVerticalScrollIndicator   = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        return scrollView
    }()
    
    private let pageControl = PageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        let contactEnums: [ContactUsDetail] = [.Sydney, .Melbourne, .Canberra]
        
        pageControl.numberOfPages = contactEnums.count
        
        addSubview(pageControl)
        pageControl.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-15)
        }
        
        var tmpView: UIView?
        for cEnum in contactEnums {
            let view = ContactUsDetailView()
            view.cEnum = cEnum
            scrollView.addSubview(view)
            
            view.snp_makeConstraints(closure: { (make) in
                make.top.bottom.width.equalTo(self)
                if let existView = tmpView {
                    make.left.equalTo(existView.snp_right)
                } else {
                    make.left.equalTo(scrollView)
                }
            })
            
            tmpView = view
        }
        
        tmpView!.snp_makeConstraints { (make) in
            make.right.equalTo(scrollView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIScrollViewDelegate
extension ContactUsFooter: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentPage = (scrollView.contentOffset.x - frame.width * 0.5) / frame.width + 1
        pageControl.currentPage = Int(currentPage)
    }
}