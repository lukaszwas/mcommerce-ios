//
//  PaymentButtonTableViewCell.swift
//  mcommerce-ios
//
//  Created by lukasz on 29.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import UIKit

class PaymentButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var payButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.payButton.backgroundColor = CustomizationManager.purchase_buttonBackgroundColor
        self.contentView.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
