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
        self.loginTitleLabel.text = NSLocalizedString("cart_login_labelText", comment: "")
        self.loginButton.setTitle(NSLocalizedString("cart_login_buttonText", comment: ""), for: UIControlState.normal)
    }
    
    // Go to login
    func goToLogin() {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let vc: LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Actions
    @IBAction func loginAction(_ sender: Any) {
        self.goToLogin()
    }

}
