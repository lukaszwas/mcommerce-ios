//
//  ImagesItemViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 15.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit
import AlamofireImage

class ImagesItemViewController: UIViewController {

    var pageIndex: Int = 0
    
    var image: String?
    
    @IBOutlet weak var productImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.image == nil || self.image == "") {
            self.productImageView.image = UIImage(named: "productdetails_noimage")
            self.productImageView.tintColor = CustomizationManager.productsDetails_noImageColor
        }
        else {
            self.productImageView.af_setImage(withURL: URL(string: self.image!)!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
