//
//  CategoriesViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 02.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit
import ALLoadingView

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Category]? = [Category]()
    var rootCategory: Category? = nil
    var parentRootCategory: Category? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
        self.initializeCell()
        
        // get categories
        self.getCategories(category: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // View styles
    func setViewStyles() {
        
    }
    
    func setCellViewStyles(cell: CategoryTableViewCell) {
        cell.separatorView.backgroundColor = CustomizationManager.instance.categories_getSeparatorColor()
        cell.nameLabel.textColor = CustomizationManager.instance.categories_getFontColor()
        
        cell.nameLabel.font = UIFont.systemFont(ofSize: 17.0)
        
        cell.nameLabelLeftConstraint.constant = 8;
        cell.speratorViewLeftConstraint.constant = 8;
        
        cell.arrowImage.image = UIImage.init(named: "categories_arrowRight")
        cell.arrowImage.tintColor = UIColor.init(red: 40.0/255.0, green: 88.0/255.0, blue: 123.0/255.0, alpha: 1)
    }
    
    // Get categories
    func getCategories(category: Category?) {
        ALLoadingView.manager.showLoadingView(ofType: .basic)
        
        var categoriesApiService: ApiService
        
        if (category == nil) {
            categoriesApiService = ApiService.getRootCategories()
        }
        else {
            categoriesApiService = ApiService.getSubategories(id: (category?.id)!)
        }
        
        ApiManager.instance.reqest(categoriesApiService) { (result: [Category]?) in
            ALLoadingView.manager.hideLoadingView()
            
            if (result?.count == 0) {
                // go to products
                return
            }
            
            self.parentRootCategory = self.rootCategory
            self.rootCategory = category
            
            self.categories = result
            self.tableView.reloadData()
        }
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
                    cell.nameLabel.text = "All categories"
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
                cell.nameLabel.text = String.init(format: "All products: %@", (self.rootCategory?.name)!)
                
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
