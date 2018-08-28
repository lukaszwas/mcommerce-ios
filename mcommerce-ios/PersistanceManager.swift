//
//  PersistanceManager.swift
//  mcommerce-ios
//
//  Created by lukasz on 19.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class PersistanceManager: NSObject {
    
    // User token
    static func getUserToken() -> String {
        let userToken = UserDefaults.standard.value(forKey: "UserToken")
        
        if (userToken == nil) {
            return ""
        }
        else {
            return userToken as! String
        }
    }
    
    static func setUserToken(userToken: String) {
        UserDefaults.standard.set(userToken, forKey: "UserToken")
    }
    
    // User id
    static func getUserId() -> Int {
        let userId = UserDefaults.standard.value(forKey: "UserId")
        
        if (userId == nil) {
            return 0
        }
        else {
            return userId as! Int
        }
    }
    
    static func setUserId(userId: Int) {
        UserDefaults.standard.set(userId, forKey: "UserId")
    }
    
    // User id
    static func getUserName() -> String {
        let userName = UserDefaults.standard.value(forKey: "UserName")
        
        if (userName == nil) {
            return ""
        }
        else {
            return userName as! String
        }
    }
    
    static func setUserName(userName: String) {
        UserDefaults.standard.set(userName, forKey: "UserName")
    }
    
    // Cart
    static func getCart() -> NSArray {
        let cart = UserDefaults.standard.object(forKey: "Cart")
        
        if (cart == nil) {
            return NSArray()
        }
        else {
            return cart as! NSArray
        }
    }
    
    static func setCart(cart: NSArray) {
        UserDefaults.standard.set(cart, forKey: "Cart")
    }
    
    static func clearCart() {
        UserDefaults.standard.set(NSArray(), forKey: "Cart")
    }
}
