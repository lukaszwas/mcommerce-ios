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
    
    static func rgb(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(Double(red)/255.0), green: CGFloat(Double(green)/255.0), blue: CGFloat(Double(blue)/255.0), alpha: 1)
    }
    
    // Navigation controller
    static let navigationController_background = rgb(red: 240, green: 242, blue: 244)
    static let navigationController_textColor = rgb(red: 85, green: 119, blue: 147)
    
    // HOME -------------
    
    // Search bar
    static let home_searchBar_backgroundColor = rgb(red: 240, green: 242, blue: 244)
    static let home_searchBar_welcomeTextColor = rgb(red: 0, green: 0, blue: 0)
    static let home_searchBar_textField_borderColor = rgb(red: 168, green: 168, blue: 168)
    static let home_searchBar_textField_textColor = rgb(red: 168, green: 168, blue: 168)
    static let home_searchBar_textField_iconColor = rgb(red: 168, green: 168, blue: 168)
    
    // Tab bar
    static let home_tabBar_backgroundColor = rgb(red: 240, green: 242, blue: 244)
    static let home_tabBar_inactiveColor = rgb(red: 168, green: 168, blue: 168)
    static let home_tabBar_activeColor = rgb(red: 85, green: 119, blue: 147)
    
    // Recommended
    static let recommended_headerColor = rgb(red: 85, green: 119, blue: 147)
    static let recommended_emptyList_imageColor = rgb(red: 168, green: 168, blue: 168)
    static let recommended_emptyList_textColor = rgb(red: 168, green: 168, blue: 168)
    
    // Categories
    static let categories_backgroundColor = rgb(red: 255, green: 255, blue: 255)
    static let categories_borderColor = rgb(red: 240, green: 242, blue: 244)
    static let categories_iconColor = rgb(red: 85, green: 119, blue: 147)
    static let categories_textColor = rgb(red: 0, green: 0, blue: 0)
    
    // Cart
    static let cart_login_buttonBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let cart_empty_imageColor = rgb(red: 85, green: 119, blue: 147)
    static let cart_products_borderColor = rgb(red: 240, green: 242, blue: 244)
    static let cart_products_textFieldBorderColor = rgb(red: 168, green: 168, blue: 168)
    static let cart_products_buyButtonBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    
    // More
    static let more_login_buttonBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let more_menu_iconsColor = rgb(red: 85, green: 119, blue: 147)
    static let more_menu_borderColor = rgb(red: 240, green: 242, blue: 244)
    
    // PRODUCTS ------------
    
    // Products list
    static let products_list_borderColor = rgb(red: 240, green: 242, blue: 244)
    static let products_emptyList_imageColor = rgb(red: 168, green: 168, blue: 168)
    static let products_emptyList_textColor = rgb(red: 168, green: 168, blue: 168)
    
    // Product details
    static let productsDetails_borderColor = rgb(red: 240, green: 242, blue: 244)
    static let productsDetails_addToCart_backgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let productsDetails_rateStar_activeBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let productsDetails_rateStar_inactiveBackgroundColor = rgb(red: 240, green: 242, blue: 244)
    static let productsDetails_noImageColor = rgb(red: 85, green: 119, blue: 147)
    
    // PURCHASE
    
    // Order details
    static let purchase_icon_imageColor = rgb(red: 85, green: 119, blue: 147)
    static let purchase_titleTextColor = rgb(red: 85, green: 119, blue: 147)
    static let purchase_buttonBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    
    // AUTH
    
    // Login
    static let auth_login_buttonBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let auth_login_borderColor = rgb(red: 168, green: 168, blue: 168)
    
    // Register
    static let auth_register_borderColor = rgb(red: 168, green: 168, blue: 168)
    static let auth_register_buttonBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    
}
