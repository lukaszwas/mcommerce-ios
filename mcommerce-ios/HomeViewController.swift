//
//  HomeViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 02.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewStyles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // View styles
    func setViewStyles() {
        // TabBar
        self.tabBar.layer.borderWidth = 0.50
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.clipsToBounds = true
        
        self.tabBar.barTintColor = CustomizationManager.instance.home_getTabBarBackgroundColor()
    }

}
