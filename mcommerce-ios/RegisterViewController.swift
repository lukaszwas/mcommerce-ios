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
        backButton.title = CustomizationManager.auth_register_title
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationController?.navigationBar.backItem?.title = CustomizationManager.auth_register_title
    }
    
    // View styles
    func setViewStyles() {
        self.navigationController?.navigationBar.backgroundColor = CustomizationManager.navigationController_background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = CustomizationManager.navigationController_textColor
        
        self.firstNameTextField.placeholder = CustomizationManager.auth_register_firstNameText
        self.lastNameTextField.placeholder = CustomizationManager.auth_register_lastNameText
        self.emailTextField.placeholder = CustomizationManager.auth_register_emailText
        self.passwordTextField.placeholder = CustomizationManager.auth_register_passwordText
        self.repeatPasswordTextField.placeholder = CustomizationManager.auth_register_repeatPasswordText
        self.registerButton.setTitle(CustomizationManager.auth_register_registerButtonText, for: UIControlState.normal)
        
        self.firstNameBorderView.backgroundColor = CustomizationManager.auth_register_borderColor
        self.lastNameBorderView.backgroundColor = CustomizationManager.auth_register_borderColor
        self.emailBorderView.backgroundColor = CustomizationManager.auth_register_borderColor
        self.passwordBorderView.backgroundColor = CustomizationManager.auth_register_borderColor
        self.repeatPasswordBorderView.backgroundColor = CustomizationManager.auth_register_borderColor
        
        self.registerButton.backgroundColor = CustomizationManager.auth_register_buttonBackgroundColor
        
    }
    
    // Actions
    @IBAction func registerAction(_ sender: Any) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }

}
