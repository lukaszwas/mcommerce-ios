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
    @IBOutlet weak var moreContentView: UIView!
    
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
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Refresh view
    func refreshView() {
        let userToken = PersistanceManager.getUserToken()
        
        remove(asChildViewController: loginView)
        remove(asChildViewController: menuView)
        
        if (userToken == "") {
            add(asChildViewController: loginView)
        }
        else {
            add(asChildViewController: menuView)
        }
    }
    
    // Child view controllers definitions
    private lazy var loginView: MoreLoginViewController = {
        let storyboard = UIStoryboard(name: "More", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "MoreLoginViewController") as! MoreLoginViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var menuView: MoreMenuViewController = {
        let storyboard = UIStoryboard(name: "More", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "MoreMenuViewController") as! MoreMenuViewController
        
        viewController.moreViewController = self
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    // Child view controllers methods
    private func add(asChildViewController viewController: UIViewController) {
        addChildViewController(viewController)
        
        self.moreContentView.addSubview(viewController.view)
        
        viewController.view.frame = self.moreContentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        
        viewController.view.removeFromSuperview()
        
        viewController.removeFromParentViewController()
    }

}
