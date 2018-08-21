//
//  RecommendedViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 18.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class RecommendedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var emptyListLabel: UILabel!
    @IBOutlet weak var emptyListImage: UIImageView!
    @IBOutlet weak var emptyListView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBarTextFieldView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var searchBarView: UIView!
    
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createSearchBar()
        self.setViewStyles()
        self.initializeCell()
        
        self.getRecommendedProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // Get recommended products
    func getRecommendedProducts() {
        ApiManager.instance.reqest(.getRecommendedProducts(), completion: { (result: Recommended?) in
            if (result == nil || result?.recommended.count == 0) {
                self.emptyListView.isHidden = false
                self.emptyListImage.tintColor = CustomizationManager.recommended_emptyList_imageColor
                self.emptyListLabel.textColor = CustomizationManager.recommended_emptyList_textColor
                self.emptyListLabel.text = NSLocalizedString("recommended_emptyList_text", comment: "")
                
                return
            }
            
            self.emptyListView.isHidden = true
            
            self.categories = (result?.recommended)!
            
            self.collectionView.reloadData()
        }) { }
    }
    
    // View styles
    func setViewStyles() {
        self.searchBarView.backgroundColor = CustomizationManager.home_searchBar_backgroundColor
        self.welcomeLabel.textColor = CustomizationManager.home_searchBar_welcomeTextColor
        self.welcomeLabel.text = NSLocalizedString("home_searchBar_welcomeText", comment: "")
    }
    
    func setCellViewStyles(cell: ProductCollectionViewCell) {
        cell.topLine.backgroundColor = CustomizationManager.products_list_borderColor
        cell.rightLine.backgroundColor = CustomizationManager.products_list_borderColor
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
    
    // Go to product details
    func goToProductDetails(productId: Int) {
        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        let vc: ProductDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        
        vc.productId = productId
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Cells
    func initializeCell() {
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        self.collectionView.register(UINib(nibName: "RecommendedHeaderCollectionReusableView", bundle: nil), forCellWithReuseIdentifier: "RecommendedHeaderCollectionReusableView")
    }
    
    // Collection view data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.categories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.categories[section].products?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        self.setCellViewStyles(cell: cell)
        
        cell.rightLine.isHidden = (indexPath.row % 2 == 1)
        
        let product: Product = self.categories[indexPath.section].products![indexPath.row]
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RecommendedHeaderCollectionReusableView", for: indexPath) as! RecommendedHeaderCollectionReusableView
            
            headerView.bottomLine.backgroundColor = CustomizationManager.products_list_borderColor
            headerView.titleLabel.textColor = CustomizationManager.recommended_headerColor
            
            headerView.titleLabel.text = self.categories[indexPath.section].name.uppercased()
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product: Product = self.categories[indexPath.section].products![indexPath.row]
        
        self.goToProductDetails(productId: product.id)
    }

}
