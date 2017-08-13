//
//  CustomizationManager.swift
//  mcommerce-ios
//
//  Created by lukasz on 07.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Foundation
import UIKit

class CustomizationManager {
    static let instance = CustomizationManager()
    
    // HOME
    func home_getTabBarBackgroundColor() -> UIColor {
        return UIColor(red: 240.0/255.0, green: 242.0/255.0, blue: 244.0/255.0, alpha: 1)
    }
    
    // CATEGORIES
    func categories_getFontColor() -> UIColor {
        return UIColor.black
    }
    
    func categories_getSeparatorColor() -> UIColor {
        return UIColor(red: 240.0/255.0, green: 242.0/255.0, blue: 244.0/255.0, alpha: 1)
    }
    
    
}
