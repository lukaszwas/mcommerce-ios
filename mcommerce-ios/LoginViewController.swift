//
//  LoginViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 19.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var registerQuestionLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordBorderView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailBorderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        let backButton = UIBarButtonItem()
        backButton.title = NSLocalizedString("auth_login_title", comment: "")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationController?.navigationBar.backItem?.title = NSLocalizedString("auth_login_title", comment: "")
    }
    
    // View styles
    func setViewStyles() {
        self.navigationController?.navigationBar.backgroundColor = CustomizationManager.navigationController_background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = CustomizationManager.navigationController_textColor
        
        self.emailBorderView.backgroundColor = CustomizationManager.auth_login_borderColor
        self.passwordBorderView.backgroundColor = CustomizationManager.auth_login_borderColor
        self.emailTextField.placeholder = NSLocalizedString("auth_login_emailText", comment: "")
        self.passwordTextField.placeholder = NSLocalizedString("auth_login_passwordText", comment: "")
        self.registerQuestionLabel.text = NSLocalizedString("auth_login_registerQuestionText", comment: "")
        self.loginButton.backgroundColor = CustomizationManager.auth_login_buttonBackgroundColor
        self.registerButton.backgroundColor = CustomizationManager.auth_login_buttonBackgroundColor
        self.loginButton.setTitle(NSLocalizedString("auth_login_buttonLoginText", comment: ""), for: UIControlState.normal)
        self.registerButton.setTitle(NSLocalizedString("auth_login_registerText", comment: ""), for: UIControlState.normal)
    }
    
    // Actions
    @IBAction func loginAction(_ sender: Any) {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        // validate
        if (email == "" || password == "") {
            let alert = UIAlertController(title: nil, message: NSLocalizedString("auth_login_emptyFieldsText", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        // login
        ApiManager.instance.reqest(.login(email: email!, password: password!), completion: { (result: Login?) in
            
            if (result == nil) {
                let alert = UIAlertController(title: nil, message: NSLocalizedString("auth_login_incorrectDataText", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                PersistanceManager.setUserToken(userToken: (result?.token)!)
                PersistanceManager.setUserId(userId: (result?.userId)!)
                PersistanceManager.setUserName(userName: String.init(format: "%@ %@", (result?.user.firstName)!, (result?.user.lastName)!))
                
                self.navigationController?.popViewController(animated: true)
            }
            
        }) { 
            let alert = UIAlertController(title: nil, message: NSLocalizedString("auth_login_incorrectDataText", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }

}
