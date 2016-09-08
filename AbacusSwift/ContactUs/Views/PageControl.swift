//
//  PageControl.swift
//  AbacusSwift
//
//  Created by maybe on 16/9/8.
//  Copyright © 2016年 Money. All rights reserved.
//

import UIKit

public class PageControl: UIView {

// MARK: - Variables
    public var numberOfPages: Int = 0 {
        didSet {
            resetPages()
        }
    }
    public var currentPage: Int   = 0 {
        willSet {
            willSelect(newValue)
        }
    }

    private let normalImage   = UIImage(named: "pagecontrol_white")
    private let selectedImage = UIImage(named: "pagecontrol_green")
    
    private func resetPages() {
        subviews.reverse().forEach { $0.removeFromSuperview() }

        var tmpView: UIView?
        for _ in 0 ..< numberOfPages {
            let imageView = UIImageView(image: normalImage)
            addSubview(imageView)
            
            imageView.snp_makeConstraints(closure: { (make) in
                make.centerY.equalTo(self)
                make.width.height.equalTo(23)
                if let exsitView = tmpView {
                    make.left.equalTo(exsitView.snp_right).offset(10)
                }
                else {
                    make.left.equalTo(self)
                }
            })
            
            tmpView = imageView
        }
        
        tmpView?.snp_makeConstraints(closure: { (make) in
            make.right.equalTo(self)
        })
        
        currentPage = 0
    }
    
    private func willSelect(newPage: Int) {
        
        if let oldSelectedImageView = subviews[currentPage] as? UIImageView where currentPage < subviews.count {
            oldSelectedImageView.image = normalImage
        }
        
        if let selectedImageView = subviews[newPage] as? UIImageView where newPage < subviews.count {
            selectedImageView.image = selectedImage
        }
    }
}
