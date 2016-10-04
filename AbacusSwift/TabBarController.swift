//
//  TabBarController.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTab()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initTab() {
        let arrayTitle = [
            ABACUS(),
            REPAYMENT(),
            STAMPDUTY(),
            CHECKLIST(),
            CONTACTUS()
        ]
        
        let arrayImageName = ["tabbar_home",  "tabbar_repayment", "tabbar_stampDuty", "tabbar_checkList", "tabbar_contactUs"]
        
        var arrayItem = [UITabBarItem] ()
        for i in 0..<arrayTitle.count {
            let imageName = arrayImageName[i]
            let imageSelectName = imageName + "Select"
            
            let item = UITabBarItem(
                title: arrayTitle[i],
                image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(named: imageSelectName)?.withRenderingMode(.alwaysOriginal)
            )
            item.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.themeGreen()], for: .selected)
            
            arrayItem.append(item)
        }
        
        let homeNVC      = BaseNavigationViewController(rootViewController:AbacusHomeViewController())
        homeNVC.tabBarItem = arrayItem[0]
        let repaymentNVC = BaseNavigationViewController(rootViewController: RepaymentViewController())
        repaymentNVC.tabBarItem = arrayItem[1]
        let stampDutyNVC = BaseNavigationViewController(rootViewController: StampDutyViewController())
        stampDutyNVC.tabBarItem = arrayItem[2]
        let checkListNVC = checkListNaviVC()
        checkListNVC.tabBarItem = arrayItem[3]
        let contactUsNVC = BaseNavigationViewController(rootViewController: ContactUsViewController())
        contactUsNVC.tabBarItem = arrayItem[4]
        
        viewControllers = [homeNVC, repaymentNVC, stampDutyNVC, checkListNVC, contactUsNVC]
    }
}

extension TabBarController {
    fileprivate func checkListNaviVC() -> UIViewController {
        let sb = UIStoryboard(name: "CheckList", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CheckListNaviVC")
        return vc
    }
}
