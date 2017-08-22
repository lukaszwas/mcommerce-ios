//
//  ProductDetailsTitleTableViewCell.swift
//  mcommerce-ios
//
//  Created by lukasz on 14.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class ProductDetailsTitleTableViewCell: UITableViewCell {

    var productDetailsViewController: ProductDetailsViewController?
    
    @IBOutlet weak var addToCartImage: UIImageView!
    @IBOutlet weak var addToCartView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Actions
    @IBAction func addToCartAction(_ sender: Any) {
        self.productDetailsViewController?.addToCart()
    }
    
}
