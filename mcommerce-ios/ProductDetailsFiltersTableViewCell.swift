//
//  ProductDetailsFiltersTableViewCell.swift
//  mcommerce-ios
//
//  Created by lukasz on 14.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class ProductDetailsFiltersTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
