//
//  ProductRate.swift
//  mcommerce-ios
//
//  Created by lukasz on 14.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Mapper

struct ProductRate: Mappable {
    let rate: Int
    let comment: String
    
    init(map: Mapper) throws {
        try rate = map.from("rate")
        try comment = map.from("comment")
    }
}
