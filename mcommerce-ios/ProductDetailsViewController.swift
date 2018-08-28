//
//  ProductDetailsViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 14.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var productId: Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    var product: Product? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeCell()
        self.setViewStyles()
        
        self.getProduct()
        
        self.navigationController?.navigationBar.backItem?.title = NSLocalizedString("navigationController_backText", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.backItem?.title = NSLocalizedString("navigationController_backText", comment: "")
        let backButton = UIBarButtonItem(title: NSLocalizedString("navigationController_backText", comment: ""), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    // Set view styles
    func setViewStyles() {
        self.navigationController?.navigationBar.backgroundColor = CustomizationManager.navigationController_background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = CustomizationManager.navigationController_textColor
    }
    
    // Get product
    func getProduct() {
        ApiManager.instance.reqest(.getProductsWithId(id: self.productId!), completion: { (result: Product?) in
            self.product = result
            self.tableView.reloadData()
        }) { }
    }
    
    // Add to cart
    func addToCart() {
        let cartItem: NSDictionary = [
            "productId" : (self.product?.id)!,
            "name" : (self.product?.name)!,
            "price" : (self.product?.price)!,
            "quantity" : 1,
            "imageUrl" : (self.product?.thumbnailUrl)!
        ]
        
        let cart: NSArray = PersistanceManager.getCart()
        let newCart = NSMutableArray(array: cart)
        
        newCart.add(cartItem)
        
        PersistanceManager.setCart(cart: newCart)
        
        let alert = UIAlertController(title: nil, message: NSLocalizedString("productsDetails_addToCartText", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // Cells
    func initializeCell() {
        self.tableView.register(UINib(nibName: "ProductDetailsImagesTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsImagesTableViewCell")
        self.tableView.register(UINib(nibName: "ProductDetailsTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsTitleTableViewCell")
        self.tableView.register(UINib(nibName: "ProductDetailsDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsDescriptionTableViewCell")
        self.tableView.register(UINib(nibName: "ProductDetailsFiltersTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsFiltersTableViewCell")
        self.tableView.register(UINib(nibName: "ProductDetailsRatesTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsRatesTableViewCell")
        self.tableView.register(UINib(nibName: "ProductDetailsHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailsHeaderTableViewCell")
    }
    
    // Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.product == nil) {
            return 0;
        }
        else {
            var count: Int = 3
            
            if (self.product?.filterValues != nil && (self.product?.filterValues?.count)! > 0) {
                count = count + 1 + (self.product?.filterValues?.count)!
            }
            
            if (self.product?.rates != nil && (self.product?.rates?.count)! > 0) {
                count = count + 1 + (self.product?.rates?.count)!
            }
            
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell: ProductDetailsImagesTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ProductDetailsImagesTableViewCell", for: indexPath) as! ProductDetailsImagesTableViewCell
            
            let storyboard = UIStoryboard(name: "Products", bundle: nil)
            let pageview: ImagesViewController = storyboard.instantiateViewController(withIdentifier: "ImagesViewController") as! ImagesViewController
            pageview.view.frame = cell.contentView.bounds
            
            pageview.images = []
            for image in (self.product?.images)! {
                pageview.images?.append(image.imageUrl)
            }
            
            cell.addSubview(pageview.view)
            
            pageview.updateView()
            
            return cell
        }
        
        if (indexPath.row == 1) {
            let cell: ProductDetailsTitleTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ProductDetailsTitleTableViewCell", for: indexPath) as! ProductDetailsTitleTableViewCell
            
            cell.productDetailsViewController = self
            
            cell.addToCartImage.image = UIImage(named: "productdetails_addToCart")
            cell.addToCartImage.tintColor = UIColor.white
            cell.addToCartView.backgroundColor = CustomizationManager.productsDetails_addToCart_backgroundColor
            
            cell.titleLabel.text = self.product?.name
            cell.priceLabel.text = String.init(format: "%.2f %@",  (self.product?.price)!, NSLocalizedString("products_currencyText", comment: ""))
            
            return cell
        }
        
        if (indexPath.row == 2) {
            let cell: ProductDetailsDescriptionTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ProductDetailsDescriptionTableViewCell", for: indexPath) as! ProductDetailsDescriptionTableViewCell
            
            cell.descriptionLabel.text = self.product?.description
            
            return cell
        }
        
        var currentCellsCount: Int = 3;
        
        if (self.product?.filterValues != nil && (self.product?.filterValues?.count)! > 0 && indexPath.row >= currentCellsCount && indexPath.row <= currentCellsCount + (self.product?.filterValues?.count)!) {
            
            if (indexPath.row == currentCellsCount) {
                let cell: ProductDetailsHeaderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ProductDetailsHeaderTableViewCell", for: indexPath) as! ProductDetailsHeaderTableViewCell
            
                cell.headerLabel.text = "SPECYFIKACJA"
                
                return cell
            }
            else {
                let cell: ProductDetailsFiltersTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ProductDetailsFiltersTableViewCell", for: indexPath) as! ProductDetailsFiltersTableViewCell
                
                cell.bottomLine.backgroundColor = CustomizationManager.productsDetails_borderColor
                
                let filterValue = self.product?.filterValues?[indexPath.row - currentCellsCount - 1]
                
                cell.titleLabel.text = filterValue?.name
                cell.valueLabel.text = filterValue?.value
                
                return cell
            }
        }
        
        if (self.product?.filterValues != nil && (self.product?.filterValues?.count)! > 0) {
            currentCellsCount = currentCellsCount + 1 + (self.product?.filterValues?.count)!
        }
        
        if (self.product?.rates != nil && (self.product?.rates?.count)! > 0 && indexPath.row >= currentCellsCount && indexPath.row <= currentCellsCount + (self.product?.rates?.count)!) {
            
            if (indexPath.row == currentCellsCount) {
                let cell: ProductDetailsHeaderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ProductDetailsHeaderTableViewCell", for: indexPath) as! ProductDetailsHeaderTableViewCell
                
                cell.headerLabel.text = String.init(format: "OPINIE (%d)", (self.product?.rates?.count)!)
                
                return cell
            }
            else {
                let cell: ProductDetailsRatesTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ProductDetailsRatesTableViewCell", for: indexPath) as! ProductDetailsRatesTableViewCell
                
                cell.bottomLine.backgroundColor = CustomizationManager.productsDetails_borderColor
                
                let rate = self.product?.rates?[indexPath.row - currentCellsCount - 1]
                
                cell.starImage1.tintColor = CustomizationManager.productsDetails_rateStar_inactiveBackgroundColor
                cell.starImage2.tintColor = CustomizationManager.productsDetails_rateStar_inactiveBackgroundColor
                cell.starImage3.tintColor = CustomizationManager.productsDetails_rateStar_inactiveBackgroundColor
                cell.starImage4.tintColor = CustomizationManager.productsDetails_rateStar_inactiveBackgroundColor
                cell.starImage5.tintColor = CustomizationManager.productsDetails_rateStar_inactiveBackgroundColor
                
                if ((rate?.rate)! > 0) {
                    cell.starImage1.tintColor = CustomizationManager.productsDetails_rateStar_activeBackgroundColor
                }
                if ((rate?.rate)! > 1) {
                    cell.starImage2.tintColor = CustomizationManager.productsDetails_rateStar_activeBackgroundColor
                }
                if ((rate?.rate)! > 2) {
                    cell.starImage3.tintColor = CustomizationManager.productsDetails_rateStar_activeBackgroundColor
                }
                if ((rate?.rate)! > 3) {
                    cell.starImage4.tintColor = CustomizationManager.productsDetails_rateStar_activeBackgroundColor
                }
                if ((rate?.rate)! > 4) {
                    cell.starImage5.tintColor = CustomizationManager.productsDetails_rateStar_activeBackgroundColor
                }
                
                cell.commentLabel.text = rate?.comment
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 180
        }
        if (indexPath.row == 1) {
            return 140
        }
        if (indexPath.row == 2) {
            
            let description: String = (self.product?.description)!
            
            return description.height(withConstrainedWidth: UIScreen.main.bounds.size.width - 16, font: UIFont.systemFont(ofSize: 14)) + 41
        }
        
        var currentCellsCount: Int = 3;
        
        if (self.product?.filterValues != nil && (self.product?.filterValues?.count)! > 0 && indexPath.row >= currentCellsCount && indexPath.row <= currentCellsCount + (self.product?.filterValues?.count)!) {
            
            if (indexPath.row == currentCellsCount) {
                return 25
            }
            else {
                return 40
            }
        }
        
        if (self.product?.filterValues != nil && (self.product?.filterValues?.count)! > 0) {
            currentCellsCount = currentCellsCount + 1 + (self.product?.filterValues?.count)!
        }
        
        if (self.product?.rates != nil && (self.product?.rates?.count)! > 0 && indexPath.row >= currentCellsCount && indexPath.row <= currentCellsCount + (self.product?.rates?.count)!) {
            
            if (indexPath.row == currentCellsCount) {
                return 50
            }
            else {
                let rate = self.product?.rates?[indexPath.row - currentCellsCount - 1]
                
                return (rate?.comment.height(withConstrainedWidth: UIScreen.main.bounds.size.width - 128, font: UIFont.systemFont(ofSize: 14)))! + 16
            }
        }
        
        return 0
    }
}
