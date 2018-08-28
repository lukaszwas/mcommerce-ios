//
//  PurchaseHistoryViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 26.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import UIKit

class PurchaseHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var purchases: [Purchase]? = [Purchase]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
        self.initializeCell()
        self.getPurchases()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.backItem?.title = NSLocalizedString("purchase_history_title", comment: "")
        let backButton = UIBarButtonItem(title: NSLocalizedString("purchase_history_title", comment: ""), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    // View styles
    func setViewStyles() {
        self.navigationController?.navigationBar.backgroundColor = CustomizationManager.navigationController_background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = CustomizationManager.navigationController_textColor
    }
    
    // Get purchases
    func getPurchases() {
        ApiManager.instance.reqest(.getAllUserPurchases(), completion: { (result: [Purchase]?) in
            self.purchases = result!
            self.tableView.reloadData()
        }) { }
    }

    // Cells
    func initializeCell() {
        self.tableView.register(UINib(nibName: "PurchaseHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "PurchaseHistoryTableViewCell")
    }
    
    // Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.purchases!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PurchaseHistoryTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "PurchaseHistoryTableViewCell", for: indexPath) as! PurchaseHistoryTableViewCell
        
        if (indexPath.row == 0) {
            cell.topBorderView.backgroundColor = UIColor.white
        }
        
        let purchaseItem: Purchase = self.purchases![indexPath.row]
        
        cell.purchaseTitle.text = NSString.init(format: "Zamówienie nr %d", indexPath.row + 1) as String
        cell.purchaseStatus.text = purchaseItem.status.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let purchaseItem: Purchase = self.purchases![indexPath.row]
        
        // go to purchase details
        let storyboard = UIStoryboard(name: "Purchase", bundle: nil)
        let vc: PurchaseHistoryDetailsViewController = storyboard.instantiateViewController(withIdentifier: "PurchaseHistoryDetailsViewController") as! PurchaseHistoryDetailsViewController
        
        vc.purchase = purchaseItem
        vc.purchaseNumber = indexPath.row + 1
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
