//
//  SearchBarViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 18.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class SearchBarViewController: UIViewController {

    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var borderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // View styles
    func setViewStyles() {
        self.borderView.backgroundColor = CustomizationManager.home_searchBar_textField_borderColor
        self.searchImage.tintColor = CustomizationManager.home_searchBar_textField_iconColor
        self.searchTextField.textColor = CustomizationManager.home_searchBar_textField_textColor
        self.searchTextField.placeholder = NSLocalizedString("home_searchBar_textField_text", comment: "")
    }
}
