//
//  PaymentViewController.swift
//  mcommerce-ios
//
//  Created by lukasz on 29.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import UIKit
import FormTextField

class PaymentViewController: UITableViewController, FormTextFieldDelegate {

    let fields = Field.fields()
    
    var cardNumber: String = ""
    var cardExpiration: String = ""
    var cardCvc: String = ""
    
    var purchaseId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1)
        self.tableView.register(FormTextFieldCell.self, forCellReuseIdentifier: FormTextFieldCell.Identifier)
        self.tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.Identifier)
        self.tableView.register(UINib(nibName: "PaymentButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "PaymentButtonTableViewCell")
        self.tableView.tableFooterView = UIView()
        
        /*let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PaymentViewController.done))
        doneButton.isEnabled = false
        navigationItem.rightBarButtonItem = doneButton*/
    }
    
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return fields.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == fields.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentButtonTableViewCell", for: indexPath) as! PaymentButtonTableViewCell
            
            cell.payButton.addTarget(self, action: #selector(PaymentViewController.done), for: UIControlEvents.touchUpInside)
            
            return cell
        }
        else {
            let field = fields[(indexPath as NSIndexPath).row]
            if field.type == .header {
                let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.Identifier, for: indexPath) as! HeaderCell
                cell.textLabel?.text = field.title.uppercased()
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: FormTextFieldCell.Identifier, for: indexPath) as! FormTextFieldCell
                cell.textField.textFieldDelegate = self
                cell.textLabel?.text = field.title
                cell.textField.placeholder = field.placeholder ?? field.title
                cell.textField.inputType = field.inputType
                cell.textField.inputValidator = field.inputValidator
                cell.textField.formatter = field.formatter
                showCheckAccessory(cell.textField)
                
                return cell
            }
        }
    }
    
    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row < fields.count) {
            let field = fields[(indexPath as NSIndexPath).row]
            if field.type == .header {
                return 45
            } else {
                return 45
            }
        }
        else {
            return 60
        }
    }
    
    @objc func done() {
        let valid = validate()
        if (!valid) {
            let alertController = UIAlertController(title: NSLocalizedString("payment_wrong_fields", comment: ""), message: nil, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        // loading indicator
        let alert = UIAlertController(title: nil, message: "Proszę czekać...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        // pay
        let indexMonth = self.cardExpiration.index(self.cardExpiration.startIndex, offsetBy: 2)
        let expirationMonth = self.cardExpiration.substring(to: indexMonth)
        
        let indexYear = self.cardExpiration.index(self.cardExpiration.endIndex, offsetBy: -2)
        let expirationYear = self.cardExpiration.substring(from: indexYear)
        
        ApiManager.instance.reqest(.pay(purchaseId: self.purchaseId, cardNumber: self.cardNumber, cardExpirationMonth: expirationMonth, cardExpirationYear: expirationYear, cardCvc: self.cardCvc), completion: { (result: String?) in
         
            self.dismiss(animated: false, completion: nil)
            
            let alert = UIAlertController(title: nil, message: NSLocalizedString("payment_success", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { UIAlertAction in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
         
         }) {
            self.dismiss(animated: false, completion: nil)
            
            let alertController = UIAlertController(title: NSLocalizedString("payment_failure", comment: ""), message: nil, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func validate() -> Bool {
        var valid = true
        for (index, field) in fields.enumerated() {
            if field.type == .field {
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! FormTextFieldCell
                let validField = cell.textField.validate()
                if validField == false {
                    valid = validField
                }
            }
        }
        return valid
    }
    
    func showCheckAccessory(_ textField: FormTextField) {
        let valid = textField.validate()
        if valid {
            let imageView = UIImageView(image: UIImage(named: "check-icon")!)
            imageView.contentMode = .center
            imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
            textField.accessoryView = imageView
            textField.accessoryViewMode = .always
        } else {
            textField.accessoryView = nil
            textField.accessoryViewMode = .never
        }
    }
    
    func formTextField(_ textField: FormTextField, didUpdateWithText text: String?) {
        showCheckAccessory(textField)
        
        if (textField.formatter is CardNumberFormatter) {
            self.cardNumber = text!
        }
        else if (textField.formatter is CardExpirationDateFormatter) {
            self.cardExpiration = text!
        }
        else {
            self.cardCvc = text!
        }
    }
}
