//
//  CartItemTableViewCell.swift
//  mcommerce-ios
//
//  Created by lukasz on 20.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var quantityTextFieldBorderView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var topBorderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setViewStyles()
        
        self.addDoneButtonOnKeyboard()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // View styles
    func setViewStyles() {
        self.quantityTextFieldBorderView.backgroundColor = CustomizationManager.cart_products_textFieldBorderColor
        self.topBorderView.backgroundColor = CustomizationManager.cart_products_borderColor
        self.quantityLabel.text = NSLocalizedString("cart_products_quantityText", comment: "")
    }
    
    // Actions
    @IBAction func quantityChangedAction(_ sender: Any) {
        if (self.quantityTextField.text == "") {
            self.quantityTextField.text = "1"
        }
        else {
            let quantity: Int = Int(self.quantityTextField.text!)!
            
            self.quantityTextField.text = String.init(format: "%d", quantity)
        }
    }
    
    // Done button on keyboard
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.done, target: self, action: #selector(CartItemTableViewCell.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.quantityTextField.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.quantityTextField.resignFirstResponder()
        self.quantityTextField.resignFirstResponder()
    }
    
}
