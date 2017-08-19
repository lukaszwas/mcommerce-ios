//
//  ProductCollectionViewCell.swift
//  mcommerce-ios
//
//  Created by lukasz on 14.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var rightLine: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var topLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
