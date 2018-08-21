//
//  MoreLoginViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 20.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class MoreLoginViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // View styles
    func setViewStyles() {
        self.loginLabel.text = NSLocalizedString("more_login_loginText", comment: "")
        self.loginButton.setTitle(NSLocalizedString("more_login_loginButtonText", comment: ""), for: UIControlState.normal)
        self.loginButton.backgroundColor = CustomizationManager.more_login_buttonBackgroundColor
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
