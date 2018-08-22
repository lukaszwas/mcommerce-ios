//
//  MoreUserDataViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 22.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import UIKit

class MoreUserDataViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var basicTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
        self.getUser()
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.backItem?.title = ""
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    // View styles
    func setViewStyles() {
        self.title = NSLocalizedString("more_userdata_title", comment: "")
        self.firstNameLabel.text = NSLocalizedString("more_userdata_firstName", comment: "")
        self.lastNameLabel.text = NSLocalizedString("more_userdata_lastName", comment: "")
        self.emailLabel.text = NSLocalizedString("more_userdata_email", comment: "")
        //self.saveButton.setTitle(NSLocalizedString("more_userdata_save", comment: ""), for: UIControlState.normal)
        
        self.navigationController?.navigationBar.backgroundColor = CustomizationManager.navigationController_background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = CustomizationManager.navigationController_textColor
    }
    
    // Get user
    func getUser() {
        ApiManager.instance.reqest(.getUserWithId(id: PersistanceManager.getUserId()), completion: { (result: UserData?) in
            self.firstNameTextField.text = result?.firstName
            self.lastNameTextField.text = result?.lastName
            self.emailField.text = result?.email
        }) { }
    }
    
    // Actions
    @IBAction func saveAction(_ sender: Any) {
        let firstName = self.firstNameTextField.text
        let lastName = self.lastNameTextField.text
        let email = self.emailField.text
        let id = PersistanceManager.getUserId()
        
        if (firstName == "" || lastName == "" || email == "") {
            let alert = UIAlertController(title: nil, message: NSLocalizedString("more_userdata_save_fail", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        ApiManager.instance.reqest(ApiService.saveUser(id: id, firstName: firstName!, lastName: lastName!, email: email!), completion: { (result: UserData?) in
            
            PersistanceManager.setUserName(userName: NSString.init(format: "%@ %@", (result?.firstName)!, (result?.lastName)!) as String)
            
            let alert = UIAlertController(title: nil, message: NSLocalizedString("more_userdata_save_success", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }) {
            let alert = UIAlertController(title: nil, message: NSLocalizedString("more_userdata_save_fail", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}
