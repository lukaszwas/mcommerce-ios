//
//  CartLoginViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 19.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class CartLoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // View styles
    func setViewStyles() {
        self.loginButton.backgroundColor = CustomizationManager.cart_login_buttonBackgroundColor
        self.loginTitleLabel.text = CustomizationManager.cart_login_labelText
        self.loginButton.setTitle(CustomizationManager.cart_login_buttonText, for: UIControlState.normal)
    }

}
