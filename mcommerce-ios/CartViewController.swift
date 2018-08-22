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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        self.refreshView()
    }
    
    // View styles
    func setViewStyles() {
        self.searchBarView.backgroundColor = CustomizationManager.home_searchBar_backgroundColor
    }
    
    // Search bar
    func createSearchBar() {
        let searchBarController = SearchBarViewController(nibName: "SearchBarViewController", bundle: nil)
        
        self.searchBarTextFieldView.addSubview(searchBarController.view)
        
        searchBarController.searchTextField.addTarget(self, action: #selector(goToProducts(_:)), for: .editingDidEndOnExit)
    }
    
    // Go to products
    func goToProducts(_ textField: UITextField) {
        if ((textField.text?.count)! > 0) {
            let storyboard = UIStoryboard(name: "Products", bundle: nil)
            let vc: ProductsViewController = storyboard.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
            
            vc.searchFilter = textField.text
            vc.categoryName = textField.text
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Refresh view
    func refreshView() {
        let userToken = PersistanceManager.getUserToken()
        
        remove(asChildViewController: loginView)
        remove(asChildViewController: emptyView)
        remove(asChildViewController: productsView)
        
        if (userToken == "") {
            add(asChildViewController: loginView)
        }
        else {
            let cart = PersistanceManager.getCart()
            
            if (cart.count == 0) {
                add(asChildViewController: emptyView)
            }
            else {
                add(asChildViewController: productsView)
            }
        }
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
        
        viewController.cartViewController = self
        
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
