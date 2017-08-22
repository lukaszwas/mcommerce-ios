//
//  MoreMenuViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 20.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import UIKit

class MoreMenuViewController: UIViewController {

    var moreViewController: MoreViewController?
    
    @IBOutlet weak var logoutBorderView: UIView!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var logoutImage: UIImageView!
    @IBOutlet weak var userDataBorderView: UIView!
    @IBOutlet weak var userDataLabel: UILabel!
    @IBOutlet weak var userDataImage: UIImageView!
    @IBOutlet weak var ordersBorderView: UIView!
    @IBOutlet weak var ordersLabel: UILabel!
    @IBOutlet weak var ordersImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userBorderView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewStyles()
        
        self.userLabel.text = PersistanceManager.getUserName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // View styles
    func setViewStyles() {
        self.userImage.tintColor = CustomizationManager.more_menu_iconsColor
        self.userBorderView.backgroundColor = CustomizationManager.more_menu_borderColor
        
        self.ordersImage.tintColor = CustomizationManager.more_menu_iconsColor
        self.ordersLabel.text = CustomizationManager.more_menu_ordersText
        self.ordersBorderView.backgroundColor = CustomizationManager.more_menu_borderColor
        
        self.userDataImage.tintColor = CustomizationManager.more_menu_iconsColor
        self.userDataLabel.text = CustomizationManager.more_menu_userDataText
        self.userDataBorderView.backgroundColor = CustomizationManager.more_menu_borderColor
        
        self.logoutImage.tintColor = CustomizationManager.more_menu_iconsColor
        self.logoutLabel.text = CustomizationManager.more_menu_logoutText
        self.logoutBorderView.backgroundColor = CustomizationManager.more_menu_borderColor
    }
    
    // Actions
    @IBAction func ordersAction(_ sender: Any) {
    }

    @IBAction func userDataAction(_ sender: Any) {
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        PersistanceManager.setUserToken(userToken: "")
        self.moreViewController?.refreshView()
    }
    
}
