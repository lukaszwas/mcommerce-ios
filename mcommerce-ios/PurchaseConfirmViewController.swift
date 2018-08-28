//
//  PurchaseConfirmViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 26.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import UIKit

class PurchaseConfirmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var firstName: String?
    var lastName: String?
    var address1: String?
    var address2: String?
    var zipCode: String?
    var city: String?
    
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTitleView: UIView!
    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var sumTitleLabel: UILabel!
    @IBOutlet weak var purchaseIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
        self.fillSumLabel()
        self.setAddress()
        self.initializeCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.backItem?.title = NSLocalizedString("purchase_confirm_title", comment: "")
        let backButton = UIBarButtonItem(title: NSLocalizedString("purchase_confirm_title", comment: ""), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    // View styles
    func setViewStyles() {
        self.navigationController?.navigationBar.backgroundColor = CustomizationManager.navigationController_background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = CustomizationManager.navigationController_textColor
        
        self.sumTitleLabel.text = NSLocalizedString("purchase_orderDetails_sum", comment: "")
        self.purchaseIcon.tintColor = CustomizationManager.purchase_icon_imageColor
        
        self.addressTitleLabel.text = NSLocalizedString("purchase_orderDetails_addressTitle", comment: "")
        
        self.addressTitleView.backgroundColor = CustomizationManager.purchase_titleTextColor
        self.addressTitleLabel.textColor = CustomizationManager.purchase_titleTextColor
        
        self.payButton.setTitle(NSLocalizedString("purchase_confirm_pay", comment: ""), for: UIControlState.normal)
        
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
    
    // Set address
    func setAddress() {
        if (address2?.count == 0) {
            self.addressLabel.text = NSString.init(format: "%@ %@\n%@\n%@ %@", firstName!, lastName!, address1!, zipCode!, city!) as String
        }
        else {
            self.addressLabel.text = NSString.init(format: "%@ %@\n%@ %@\n%@ %@", firstName!, lastName!, address1!, address2!, zipCode!, city!) as String
        }
    }
    
    // Cells
    func initializeCell() {
        
        self.tableView.register(UINib(nibName: "PurchaseConfirmProductTableViewCell", bundle: nil), forCellReuseIdentifier: "PurchaseConfirmProductTableViewCell")
    }
    
    // Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cart = PersistanceManager.getCart()
        
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PurchaseConfirmProductTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "PurchaseConfirmProductTableViewCell", for: indexPath) as! PurchaseConfirmProductTableViewCell
        
        if (indexPath.row == 0) {
            cell.topBorderView.backgroundColor = UIColor.white
        }
        
        let cart = PersistanceManager.getCart()
        
        let cartItem: NSDictionary = cart.object(at: indexPath.row) as! NSDictionary
        
        let name: String = cartItem.value(forKey: "name") as! String
        let price: Float = cartItem.value(forKey: "price") as! Float
        let quantity: Int = cartItem.value(forKey: "quantity") as! Int
        let imageUrl: String = cartItem.value(forKey: "imageUrl") as! String
        
        cell.nameLabel.text = name
        cell.priceLabel.text = String.init(format: "%.2f", price)
        cell.quantityTitleLabel.text = String.init(format: "%d", quantity)
        cell.productImage.af_setImage(withURL: URL(string: imageUrl)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Pay action
    @IBAction func payAction(_ sender: Any) {
        // add purchase
        ApiManager.instance.reqest(.purchase(userId: PersistanceManager.getUserId(), statusId: 1, firstName: firstName!, lastName: lastName!, address1: address1!, address2: address2!, zipCode: zipCode!, city: city!), completion: { (result: Purchase?) in
            
            // add products
            let cart = PersistanceManager.getCart()
            
            for cartItem in cart {
                let price: Float = (cartItem as! NSDictionary).value(forKey: "price") as! Float
                let productId: Int = (cartItem as! NSDictionary).value(forKey: "productId") as! Int
                
                ApiManager.instance.reqest(.purchaseAddProduct(purchaseId: (result?.id)!, productId: productId, price: price), completion: { (result: PurchaseProduct?) in
                }) { }
                
                PersistanceManager.clearCart()
                self.navigationController?.popToRootViewController(animated: true)
            }
        }) { }
    }
}
