//
//  MoreViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 18.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var searchBarTextFieldView: UIView!
    @IBOutlet weak var searchBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createSearchBar()
        self.setViewStyles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // View styles
    func setViewStyles() {
        self.searchBarView.backgroundColor = CustomizationManager.home_searchBar_backgroundColor
    }
    
    // Search bar
    func createSearchBar() {
        let searchBarController = SearchBarViewController(nibName: "SearchBarViewController", bundle: nil)
        
        self.searchBarTextFieldView.addSubview(searchBarController.view)
    }

}
