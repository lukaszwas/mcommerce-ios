//
//  CartViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 18.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var searchBarTextFieldView: UIView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var cartContentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createSearchBar()
        self.setViewStyles()
        
        add(asChildViewController: emptyView)
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
    
    // Child view controllers definitions
    private lazy var loginView: CartLoginViewController = {
        let storyboard = UIStoryboard(name: "Cart", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "CartLoginViewController") as! CartLoginViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var emptyView: CartEmptyViewController = {
        let storyboard = UIStoryboard(name: "Cart", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "CartEmptyViewController") as! CartEmptyViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var productsView: CartProductsViewController = {
        let storyboard = UIStoryboard(name: "Cart", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "CartProductsViewController") as! CartProductsViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    // Child view controllers methods
    private func add(asChildViewController viewController: UIViewController) {
        addChildViewController(viewController)
        
        self.cartContentView.addSubview(viewController.view)
        
        viewController.view.frame = self.cartContentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        
        viewController.view.removeFromSuperview()
        
        viewController.removeFromParentViewController()
    }
}
