//
//  CartEmptyViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 19.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class CartEmptyViewController: UIViewController {

    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // View styles
    func setViewStyles() {
        self.emptyImage.tintColor = CustomizationManager.cart_empty_imageColor
        self.emptyLabel.text = CustomizationManager.cart_empty_labelText
    }

}
