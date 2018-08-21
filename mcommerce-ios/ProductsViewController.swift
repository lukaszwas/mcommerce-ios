//
//  ProductsViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 14.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var emptyListLabel: UILabel!
    @IBOutlet weak var emptyListImage: UIImageView!
    @IBOutlet weak var emptyListView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoryId: Int?
    var categoryName: String?
    var searchFilter: String?
    var products: [Product]? = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeCell()
        self.setViewStyles()
        
        self.getProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.backItem?.title = self.categoryName
    }
    
    // View styles
    func setViewStyles() {
        self.navigationController?.navigationBar.backgroundColor = CustomizationManager.navigationController_background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = CustomizationManager.navigationController_textColor
    }
    
    func setCellViewStyles(cell: ProductCollectionViewCell) {
        cell.topLine.backgroundColor = CustomizationManager.products_list_borderColor
        cell.rightLine.backgroundColor = CustomizationManager.products_list_borderColor
    }
    
    // Actions
    @IBAction func filtersAction(_ sender: Any) {
        self.goToFilters()
    }
    
    // Go to product details
    func goToProductDetails(productId: Int) {
        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        let vc: ProductDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        
        vc.productId = productId
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Go to filters
    func goToFilters() {
        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        let vc: ProductsFiltersViewController = storyboard.instantiateViewController(withIdentifier: "ProductsFiltersViewController") as! ProductsFiltersViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Get products
    func getProducts() {
        if (searchFilter != nil && (searchFilter?.count)! > 0) {
            ApiManager.instance.reqest(.searchProducts(filter: self.searchFilter!), completion: { (result: [Product]?) in
                if (result?.count == 0) {
                    self.emptyListView.isHidden = false
                    self.emptyListImage.tintColor = CustomizationManager.products_emptyList_imageColor
                    self.emptyListLabel.textColor = CustomizationManager.products_emptyList_textColor
                    self.emptyListLabel.text = NSLocalizedString("products_emptyList_text", comment: "")
                    
                    return
                }
                
                self.emptyListView.isHidden = true
                
                self.products = result
                self.collectionView.reloadData()
            }) { }
        }
        else {
            ApiManager.instance.reqest(.getProductsWithCategoryId(categoryId: self.categoryId!), completion: { (result: [Product]?) in
                if (result?.count == 0) {
                    self.emptyListView.isHidden = false
                    self.emptyListImage.tintColor = CustomizationManager.products_emptyList_imageColor
                    self.emptyListLabel.textColor = CustomizationManager.products_emptyList_textColor
                    self.emptyListLabel.text = NSLocalizedString("products_emptyList_text", comment: "")
                    
                    return
                }
                
                self.emptyListView.isHidden = true
                
                self.products = result
                self.collectionView.reloadData()
            }) { }
        }
    }
    
    // Cells
    func initializeCell() {
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
    }
    
    // Collection view data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.products?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        self.setCellViewStyles(cell: cell)
        
        cell.rightLine.isHidden = (indexPath.row % 2 == 1)
        
        let product: Product = self.products![indexPath.row]
        
        cell.productImageView.af_setImage(withURL: URL(string: product.thumbnailUrl)!)
        cell.titleLabel.text = product.name
        cell.priceLabel.text = String(format: "%.2f%@", product.price, NSLocalizedString("products_currencyText", comment: ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = view.frame.width / 2
        return CGSize(width: widthPerItem, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product: Product = self.products![indexPath.row]
        
        self.goToProductDetails(productId: product.id)
    }
}
