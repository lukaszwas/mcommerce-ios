//
//  ApplicationExtensions.swift
//  mcommerce-ios
//
//  Created by lukasz on 19.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
