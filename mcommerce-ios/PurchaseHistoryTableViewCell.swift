//
//  PurchaseHistoryTableViewCell.swift
//  mcommerce-ios
//
//  Created by lukasz on 26.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import UIKit

class PurchaseHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var purchaseStatus: UILabel!
    @IBOutlet weak var topBorderView: UIView!
    @IBOutlet weak var purchaseTitle: UILabel!
    @IBOutlet weak var purchaseIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setViewStyles()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Set view styles
    func setViewStyles() {
        self.purchaseIcon.tintColor = CustomizationManager.purchase_icon_imageColor
        self.topBorderView.backgroundColor = CustomizationManager.cart_products_borderColor
    }
    
}
