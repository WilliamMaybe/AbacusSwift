//
//  PageControl.swift
//  AbacusSwift
//
//  Created by maybe on 16/9/8.
//  Copyright © 2016年 Money. All rights reserved.
//

import UIKit

open class PageControl: UIView {

// MARK: - Variables
    open var numberOfPages: Int = 0 {
        didSet {
            resetPages()
        }
    }
    open var currentPage: Int   = 0 {
        willSet {
            willSelect(newValue)
        }
    }

    fileprivate let normalImage   = UIImage(named: "pagecontrol_white")
    fileprivate let selectedImage = UIImage(named: "pagecontrol_green")
    
    fileprivate func resetPages() {
        subviews.reversed().forEach { $0.removeFromSuperview() }

        var tmpView: UIView?
        for _ in 0 ..< numberOfPages {
            let imageView = UIImageView(image: normalImage)
            addSubview(imageView)
            
            imageView.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self)
                make.width.height.equalTo(23)
                if let exsitView = tmpView {
                    make.left.equalTo(exsitView.snp.right).offset(10)
                }
                else {
                    make.left.equalTo(self)
                }
            })
            
            tmpView = imageView
        }
        
        tmpView?.snp.makeConstraints({ (make) in
            make.right.equalTo(self)
        })
        
        currentPage = 0
    }
    
    fileprivate func willSelect(_ newPage: Int) {
        
        if let oldSelectedImageView = subviews[currentPage] as? UIImageView , currentPage < subviews.count {
            oldSelectedImageView.image = normalImage
        }
        
        if let selectedImageView = subviews[newPage] as? UIImageView , newPage < subviews.count {
            selectedImageView.image = selectedImage
        }
    }
}
