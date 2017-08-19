//
//  ProductFilterValue.swift
//  mcommerce-ios
//
//  Created by lukasz on 14.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Mapper

struct ProductFilterValue: Mappable {
    let name: String
    let value: String
    
    init(map: Mapper) throws {
        try name = map.from("name")
        try value = map.from("value")
    }
}
