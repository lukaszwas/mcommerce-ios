//
//  CartProductsViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 19.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class CartProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var cartViewController: CartViewController?
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var sumTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeCell()
        self.setViewStyles()
        self.fillSumLabel()
        
        self.tableView.allowsMultipleSelectionDuringEditing = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.fillSumLabel()
    }
    
    // View styles
    func setViewStyles() {
        self.buyButton.backgroundColor = CustomizationManager.cart_products_buyButtonBackgroundColor
        self.buyButton.setTitle(CustomizationManager.cart_products_buyButtonText, for: .normal)
        self.sumTitleLabel.text = CustomizationManager.cart_products_sumTitleText
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
        
        self.sumLabel.text = String.init(format: "%.2f %@", sum, CustomizationManager.products_currencyText)
    }
    
    // Cells
    func initializeCell() {
        self.tableView.register(UINib(nibName: "CartItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CartItemTableViewCell")
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
        let cell: CartItemTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! CartItemTableViewCell
        
        let cart = PersistanceManager.getCart()
        
        let cartItem: NSDictionary = cart.object(at: indexPath.row) as! NSDictionary
        
        let name: String = cartItem.value(forKey: "name") as! String
        let price: Float = cartItem.value(forKey: "price") as! Float
        let quantity: Int = cartItem.value(forKey: "quantity") as! Int
        let imageUrl: String = cartItem.value(forKey: "imageUrl") as! String
        
        cell.nameLabel.text = name
        cell.priceLabel.text = String.init(format: "%.2f", price)
        cell.quantityTextField.text = String.init(format: "%d", quantity)
        cell.productImage.af_setImage(withURL: URL(string: imageUrl)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let cart: NSArray = PersistanceManager.getCart()
            let newCart = NSMutableArray(array: cart)
            
            newCart.removeObject(at: indexPath.row)
            
            PersistanceManager.setCart(cart: newCart)
            
            if (newCart.count == 0) {
                self.cartViewController?.refreshView()
            }
            else {
                self.tableView.reloadData()
                self.fillSumLabel()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return CustomizationManager.cart_products_deleteText
    }

}
