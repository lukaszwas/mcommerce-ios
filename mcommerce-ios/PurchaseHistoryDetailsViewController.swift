//
//  PurchaseHistoryDetailsViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 26.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import UIKit

class PurchaseHistoryDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var purchase: Purchase?
    var purchaseNumber: Int?
    
    var purchaseProducts: [PurchaseProduct]? = [PurchaseProduct]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productsLineView: UIView!
    @IBOutlet weak var addressLineView: UIView!
    @IBOutlet weak var productsTitleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var purchaseStatus: UILabel!
    @IBOutlet weak var purchaseTitle: UILabel!
    @IBOutlet weak var purchaseIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
        self.setOrderDetails()
        self.initializeCell()
        self.getPurchaseProducts()
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
    
    // View styles
    func setViewStyles() {
        self.navigationController?.navigationBar.backgroundColor = CustomizationManager.navigationController_background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = CustomizationManager.navigationController_textColor
        
        self.purchaseIcon.tintColor = CustomizationManager.purchase_icon_imageColor
        self.addressTitleLabel.textColor = CustomizationManager.purchase_icon_imageColor
        self.addressLineView.backgroundColor = CustomizationManager.purchase_icon_imageColor
        self.productsLineView.backgroundColor = CustomizationManager.purchase_icon_imageColor
        self.productsTitleLabel.textColor = CustomizationManager.purchase_icon_imageColor
        
    }

    // Set order details
    func setOrderDetails() {
        self.purchaseTitle.text = NSString.init(format: "Zamówienie nr %d", self.purchaseNumber!) as String
        self.purchaseStatus.text = self.purchase!.status.name
        
        if (self.purchase!.address2?.count == 0) {
            self.addressLabel.text = NSString.init(format: "%@ %@\n%@\n%@ %@", self.purchase!.firstName, self.purchase!.lastName, self.purchase!.address1, self.purchase!.zipCode, self.purchase!.city) as String
        }
        else {
            self.addressLabel.text = NSString.init(format: "%@ %@\n%@ %@\n%@ %@", self.purchase!.firstName, self.purchase!.lastName, self.purchase!.address1, self.purchase!.address2!, self.purchase!.zipCode, self.purchase!.city) as String
        }
    }
    
    // Get purchase products
    func getPurchaseProducts() {
        ApiManager.instance.reqest(.getPurchaseProducts(purchaseId: (self.purchase?.id)!), completion: { (result: [PurchaseProduct]?) in
            self.purchaseProducts = result!
            self.tableView.reloadData()
        }) { }
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
        return self.purchaseProducts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PurchaseConfirmProductTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "PurchaseConfirmProductTableViewCell", for: indexPath) as! PurchaseConfirmProductTableViewCell
        
        if (indexPath.row == 0) {
            cell.topBorderView.backgroundColor = UIColor.white
        }
        
        let puchaseItem = self.purchaseProducts![indexPath.row]
        
        cell.nameLabel.text = puchaseItem.product.name
        cell.priceLabel.text = String.init(format: "%.2f", puchaseItem.price)
        cell.quantityTitleLabel.text = String.init(format: "%d", 1)
        cell.productImage.af_setImage(withURL: URL(string: puchaseItem.product.thumbnailUrl)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
