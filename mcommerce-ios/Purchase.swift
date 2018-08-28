//
//  Purchase.swift
//  mcommerce-ios
//
//  Created by lukasz on 26.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import Mapper

struct Purchase: Mappable {
    let id: Int
    let userId: Int
    let statusId: Int
    let status: PurchaseStatus
    let firstName: String
    let lastName: String
    let address1: String
    let address2: String?
    let zipCode: String
    let city: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try userId = map.from("user_id")
        try statusId = map.from("statusId")
        try status = map.from("status")
        try firstName = map.from("first_name")
        try lastName = map.from("last_name")
        try address1 = map.from("address1")
        address2 = map.optionalFrom("address2")
        try zipCode = map.from("zip_code")
        try city = map.from("city")
    }
}
