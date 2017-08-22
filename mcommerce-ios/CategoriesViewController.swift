//
//  CategoriesViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 02.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchBarTextFieldView: UIView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Category]? = [Category]()
    var rootCategory: Category? = nil
    var parentRootCategory: Category? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createSearchBar()
        self.setViewStyles()
        self.initializeCell()
        
        // get categories
        self.getCategories(category: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // View styles
    func setViewStyles() {
        self.view.backgroundColor = CustomizationManager.categories_backgroundColor
        self.searchBarView.backgroundColor = CustomizationManager.home_searchBar_backgroundColor
    }
    
    func setCellViewStyles(cell: CategoryTableViewCell) {
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.clear
        
        cell.separatorView.backgroundColor = CustomizationManager.categories_borderColor
        cell.nameLabel.textColor = CustomizationManager.categories_textColor
        
        cell.nameLabelLeftConstraint.constant = 8;
        cell.speratorViewLeftConstraint.constant = 8;
        
        cell.nameLabel.font = UIFont.systemFont(ofSize: 17.0)
        
        cell.arrowImage.image = UIImage.init(named: "categories_arrowRight")
        cell.arrowImage.tintColor = CustomizationManager.categories_iconColor
    }
    
    // Search bar
    func createSearchBar() {
        let searchBarController = SearchBarViewController(nibName: "SearchBarViewController", bundle: nil)
        
        self.searchBarTextFieldView.addSubview(searchBarController.view)
    }
    
    // Get categories
    func getCategories(category: Category?) {
        var categoriesApiService: ApiService
        
        if (category == nil) {
            categoriesApiService = ApiService.getRootCategories()
        }
        else {
            categoriesApiService = ApiService.getSubategories(id: (category?.id)!)
        }
        
        ApiManager.instance.reqest(categoriesApiService, completion: { (result: [Category]?) in
            if (result?.count == 0) {
                // go to products
                self.goToProducts(category: category!)
                
                return
            }
            
            self.parentRootCategory = self.rootCategory
            self.rootCategory = category
            
            self.categories = result
            self.tableView.reloadData()
        }) { }
    }
    
    // Go to products
    func goToProducts(category: Category) {
        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        let vc: ProductsViewController = storyboard.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        
        vc.categoryId = category.id
        vc.categoryName = category.name
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Cells
    func initializeCell() {
        self.tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }

    // Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = (self.categories?.count)!
        
        if (self.rootCategory != nil) {
            count += 2
        }
        
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell

        self.setCellViewStyles(cell: cell)
        
        // set cell content
        var categoryPosition: Int
        
        if (self.rootCategory == nil) {
            categoryPosition = indexPath.row
        }
        else {
            if (indexPath.row == 0) {
                // come back row
                if (self.parentRootCategory == nil) {
                    cell.nameLabel.text = CustomizationManager.categories_allCategoriesText
                }
                else {
                    cell.nameLabel.text = self.parentRootCategory?.name
                }
                cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
                
                cell.arrowImage.image = UIImage.init(named: "categories_arrowUp")
                
                return cell
            }
            else if (indexPath.row == 1) {
                // all products from category
                cell.nameLabel.text = String.init(format: "%@%@", CustomizationManager.categories_allProductsText, (self.rootCategory?.name)!)
                
                cell.nameLabelLeftConstraint.constant = 40;
                cell.speratorViewLeftConstraint.constant = 40;
                
                return cell
            }
            else {
                categoryPosition = indexPath.row - 2
            }
        }
        
        let category: Category? = self.categories?[categoryPosition]
        
        cell.nameLabel.text = category?.name
        
        if (self.rootCategory != nil) {
            cell.nameLabelLeftConstraint.constant = 40;
            cell.speratorViewLeftConstraint.constant = 40;
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.rootCategory != nil && indexPath.row == 0) {
            // come back to parent
            self.getCategories(category: self.parentRootCategory)
        }
        else if (self.rootCategory != nil && indexPath.row == 1) {
            // go to products
            self.goToProducts(category: self.rootCategory!)
        }
        else {
            // show subcategoreis
            var categoryPosition: Int = indexPath.row
            
            if (self.rootCategory != nil) {
                categoryPosition -= 2
            }
            
            let category: Category? = self.categories?[categoryPosition]
            
            self.getCategories(category: category)
        }
    }

}
