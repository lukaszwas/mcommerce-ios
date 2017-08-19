//
//  ProductDetailsRatesTableViewCell.swift
//  mcommerce-ios
//
//  Created by lukasz on 14.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class ProductDetailsRatesTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var starImage5: UIImageView!
    @IBOutlet weak var starImage4: UIImageView!
    @IBOutlet weak var starImage3: UIImageView!
    @IBOutlet weak var starImage2: UIImageView!
    @IBOutlet weak var starImage1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
