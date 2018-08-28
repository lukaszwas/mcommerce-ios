//
//  PurchaseConfirmProductTableViewCell.swift
//  mcommerce-ios
//
//  Created by lukasz on 26.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import UIKit

class PurchaseConfirmProductTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityTitleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var topBorderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setViewStyles()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // View styles
    func setViewStyles() {
        self.topBorderView.backgroundColor = CustomizationManager.cart_products_borderColor
        self.quantityLabel.text = NSLocalizedString("cart_products_quantityText", comment: "")
    }
    
}
