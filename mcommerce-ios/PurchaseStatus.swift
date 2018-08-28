//
//  PurchaseStatus.swift
//  mcommerce-ios
//
//  Created by lukasz on 26.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import Mapper

struct PurchaseStatus: Mappable {
    let id: Int
    let name: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
    }
}
