//
//  RegisterViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 19.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordBorderView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordBorderView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailBorderView: UIView!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var lastNameBorderView: UIView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameBorderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.repeatPasswordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        let backButton = UIBarButtonItem()
        backButton.title = NSLocalizedString("auth_register_title", comment: "")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationController?.navigationBar.backItem?.title = NSLocalizedString("auth_register_title", comment: "")
    }
    
    // View styles
    func setViewStyles() {
        self.navigationController?.navigationBar.backgroundColor = CustomizationManager.navigationController_background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = CustomizationManager.navigationController_textColor
        
        self.firstNameTextField.placeholder = NSLocalizedString("auth_register_firstNameText", comment: "")
        self.lastNameTextField.placeholder = NSLocalizedString("auth_register_lastNameText", comment: "")
        self.emailTextField.placeholder = NSLocalizedString("auth_register_emailText", comment: "")
        self.passwordTextField.placeholder = NSLocalizedString("auth_register_passwordText", comment: "")
        self.repeatPasswordTextField.placeholder = NSLocalizedString("auth_register_repeatPasswordText", comment: "")
        self.registerButton.setTitle(NSLocalizedString("auth_register_registerButtonText", comment: ""), for: UIControlState.normal)
        
        self.firstNameBorderView.backgroundColor = CustomizationManager.auth_register_borderColor
        self.lastNameBorderView.backgroundColor = CustomizationManager.auth_register_borderColor
        self.emailBorderView.backgroundColor = CustomizationManager.auth_register_borderColor
        self.passwordBorderView.backgroundColor = CustomizationManager.auth_register_borderColor
        self.repeatPasswordBorderView.backgroundColor = CustomizationManager.auth_register_borderColor
        
        self.registerButton.backgroundColor = CustomizationManager.auth_register_buttonBackgroundColor
    }
    
    // Actions
    @IBAction func registerAction(_ sender: Any) {
        let firstName = self.firstNameTextField.text
        let lastName = self.lastNameTextField.text
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        let repeatPassword = self.repeatPasswordTextField.text
        
        if (firstName == "" || lastName == "" || email == "" || password == "" || repeatPassword == "") {
            let alert = UIAlertController(title: nil, message: NSLocalizedString("auth_register_fail", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (password != repeatPassword) {
            let alert = UIAlertController(title: nil, message: NSLocalizedString("auth_register_differentPasswords", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if ((password?.count)! < 6) {
            let alert = UIAlertController(title: nil, message: NSLocalizedString("auth_register_passwordMin6Chars", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            ApiManager.instance.reqest(ApiService.register(firstName: firstName!, lastName: lastName!, email: email!, password: password!), completion: { (result: UserData?) in
                
                let alert = UIAlertController(title: nil, message: NSLocalizedString("auth_register_success", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { UIAlertAction in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }) {
                let alert = UIAlertController(title: nil, message: NSLocalizedString("auth_register_fail", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }

}
