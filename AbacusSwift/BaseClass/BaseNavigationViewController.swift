//
//  BaseNavigationViewController.swift
//  AbacusSwift
//
//  Created by williamzhang on 15/11/3.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = UIColor.themeGreen()
        navigationBar.tintColor = UIColor.whiteColor()
        
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName:UIColor.whiteColor(),
            NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 22)!]
        
        navigationBar.translucent = false
        
        navigationBar.backItem?.title = localStringFromKey(BACK)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
