//
//  Field.swift
//  mcommerce-ios
//
//  Created by lukasz on 29.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import UIKit
import FormTextField

enum FieldType {
    case header, field
}

struct Field {
    let type: FieldType
    let title: String
    let placeholder: String?
    var inputType: FormTextFieldInputType = .default
    var inputValidator: InputValidatable?
    var formatter: Formattable?
    
    init(type: FieldType, title: String, placeholder: String? = nil) {
        self.type = type
        self.title = title
        self.placeholder = placeholder
    }
    
    static func fields() -> [Field] {
        var items = [Field]()
        
        items.append(Field(type: .header, title: NSLocalizedString("payment_card_title", comment: "")))
        
        let cardNumberField: Field = {
            var field = Field(type: .field, title: NSLocalizedString("payment_card_number", comment: ""), placeholder: NSLocalizedString("payment_card_placeholder_number", comment: ""))
            field.inputType = .integer
            field.formatter = CardNumberFormatter()
            var validation = Validation()
            validation.minimumLength = "1234 5678 1234 5678".count
            validation.maximumLength = "1234 5678 1234 5678".count
            let characterSet = NSMutableCharacterSet.decimalDigit()
            characterSet.addCharacters(in: " ")
            validation.characterSet = characterSet as CharacterSet
            let inputValidator = InputValidator(validation: validation)
            field.inputValidator = inputValidator
            
            return field
        }()
        items.append(cardNumberField)
        
        let expirationDateField: Field = {
            var field = Field(type: .field, title: NSLocalizedString("payment_card_expire", comment: ""), placeholder: NSLocalizedString("payment_card_placeholder_expire", comment: ""))
            field.formatter = CardExpirationDateFormatter()
            field.inputType = .integer
            var validation = Validation()
            validation.minimumLength = 1
            let inputValidator = CardExpirationDateInputValidator(validation: validation)
            field.inputValidator = inputValidator
            
            return field
        }()
        items.append(expirationDateField)
        
        let securityCodeField: Field = {
            var field = Field(type: .field, title: NSLocalizedString("payment_card_cvc", comment: ""), placeholder: NSLocalizedString("payment_card_placeholder_cvc", comment: ""))
            field.inputType = .integer
            var validation = Validation()
            validation.maximumLength = "CVC".count
            validation.minimumLength = "CVC".count
            validation.characterSet = CharacterSet.decimalDigits
            let inputValidator = InputValidator(validation: validation)
            field.inputValidator = inputValidator
            
            return field
        }()
        items.append(securityCodeField)
        
        return items
    }
}
