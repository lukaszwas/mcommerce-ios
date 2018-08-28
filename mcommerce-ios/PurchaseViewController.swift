//
//  PurchaseViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 21.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController {

    @IBOutlet weak var addressTitleView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var sumTitleLabel: UILabel!
    @IBOutlet weak var orderIconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
        self.fillSumLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.backItem?.title = NSLocalizedString("purchase_orderDetails_title", comment: "")
        let backButton = UIBarButtonItem(title: NSLocalizedString("purchase_orderDetails_title", comment: ""), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    // View styles
    func setViewStyles() {
        self.navigationController?.navigationBar.backgroundColor = CustomizationManager.navigationController_background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = CustomizationManager.navigationController_textColor
        
        self.sumTitleLabel.text = NSLocalizedString("purchase_orderDetails_sum", comment: "")
        self.orderIconImage.tintColor = CustomizationManager.purchase_icon_imageColor
        
        self.addressTitleLabel.text = NSLocalizedString("purchase_orderDetails_addressTitle", comment: "")
        self.nextButton.setTitle(NSLocalizedString("purchase_orderDetails_nextButton", comment: ""), for: UIControlState.normal)
        
        self.firstNameTextField.placeholder = NSLocalizedString("purchase_address_firstName", comment: "")
        self.lastNameTextField.placeholder = NSLocalizedString("purchase_address_lastName", comment: "")
        self.address1TextField.placeholder = NSLocalizedString("purchase_address_address", comment: "")
        self.address2TextField.placeholder = NSLocalizedString("purchase_address_address", comment: "")
        self.zipCodeTextField.placeholder = NSLocalizedString("purchase_address_zipCode", comment: "")
        self.cityTextField.placeholder = NSLocalizedString("purchase_address_city", comment: "")
        
        self.addressTitleView.backgroundColor = CustomizationManager.purchase_titleTextColor
        self.addressTitleLabel.textColor = CustomizationManager.purchase_titleTextColor
        self.nextButton.backgroundColor = CustomizationManager.purchase_buttonBackgroundColor
    }
    
    // Fill sum label
    func fillSumLabel() {
        let cart = PersistanceManager.getCart()
        
        var sum: Float = 0
        
        for cartItem in cart {
            let price: Float = (cartItem as! NSDictionary).value(forKey: "price") as! Float
            let quantity: Int = (cartItem as! NSDictionary).value(forKey: "quantity") as! Int
            
            sum = sum + (price * Float.init(quantity))
        }
        
        self.sumLabel.text = String.init(format: "%.2f %@", sum, NSLocalizedString("products_currencyText", comment: ""))
    }
    
    // Next action
    @IBAction func nextAction(_ sender: Any) {
        // validate
        if (self.firstNameTextField.text?.count == 0
            || self.lastNameTextField.text?.count == 0
            || self.address1TextField.text?.count == 0
            || self.address2TextField.text?.count == 0
            || self.cityTextField.text?.count == 0) {
            let alert = UIAlertController(title: nil, message: NSLocalizedString("purchase_orderDetails_emptyData", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        // go to confirm page
        let storyboard = UIStoryboard(name: "Purchase", bundle: nil)
        let vc: PurchaseConfirmViewController = storyboard.instantiateViewController(withIdentifier: "PurchaseConfirmViewController") as! PurchaseConfirmViewController
        
        vc.firstName = self.firstNameTextField.text
        vc.lastName = self.lastNameTextField.text
        vc.address1 = self.address1TextField.text
        vc.address2 = self.address2TextField.text
        vc.zipCode = self.zipCodeTextField.text
        vc.city = self.cityTextField.text
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
