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
        
        self.tabBar.barTintColor = CustomizationManager.home_tabBar_backgroundColor
        self.tabBar.tintColor = CustomizationManager.home_tabBar_activeColor
        self.tabBar.unselectedItemTintColor = CustomizationManager.home_tabBar_inactiveColor
        
        self.tabBar.items![0].title = NSLocalizedString("home_tabBar_recommendedText", comment: "")
        self.tabBar.items![1].title = NSLocalizedString("home_tabBar_categoriesText", comment: "")
        self.tabBar.items![2].title = NSLocalizedString("home_tabBar_cartText", comment: "")
        self.tabBar.items![3].title = NSLocalizedString("home_tabBar_moreText", comment: "")
    }

}
