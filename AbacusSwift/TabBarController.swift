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
    
    private func initTab() {
        let arrayTitle = [
            localStringFromKey(ABACUS),
            localStringFromKey(REPAYMENT),
            localStringFromKey(STAMPDUTY),
            localStringFromKey(CHECKLIST),
            localStringFromKey(CONTACTUS)
        ]
        
        let arrayImageName       = ["tabbar_home",  "tabbar_repayment", "tabbar_stampDuty", "tabbar_checkList", "tabbar_contactUs"]
        
        var arrayItem = [UITabBarItem] ()
        for var i = 0; i < arrayTitle.count; i++ {
            let imageName = arrayImageName[i]
            let imageSelectName = imageName + "Select"
            
            let item = UITabBarItem(
                title: arrayTitle[i],
                image: UIImage(named: imageName)?.imageWithRenderingMode(.AlwaysOriginal),
                selectedImage: UIImage(named: imageSelectName)?.imageWithRenderingMode(.AlwaysOriginal)
            )
            item.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.themeGreen()], forState: .Selected)
            
            arrayItem.append(item)
        }
        
        let homeNVC      = BaseNavigationViewController(rootViewController:AbacusHomeViewController())
        homeNVC.tabBarItem = arrayItem[0]
        let repaymentNVC = BaseNavigationViewController(rootViewController: RepaymentViewController())
        repaymentNVC.tabBarItem = arrayItem[1]
        let stampDutyNVC = BaseNavigationViewController(rootViewController: StampDutyViewController())
        stampDutyNVC.tabBarItem = arrayItem[2]
        let checkListNVC = BaseNavigationViewController(rootViewController: CheckListViewController())
        checkListNVC.tabBarItem = arrayItem[3]
        let contactUsNVC = BaseNavigationViewController(rootViewController: ContactUsViewController())
        contactUsNVC.tabBarItem = arrayItem[4]
        
        viewControllers = [homeNVC, repaymentNVC, stampDutyNVC, checkListNVC, contactUsNVC]
    }
}
