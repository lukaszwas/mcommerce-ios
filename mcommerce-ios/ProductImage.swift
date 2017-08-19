//
//  ProductImage.swift
//  mcommerce-ios
//
//  Created by lukasz on 14.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Mapper

struct ProductImage: Mappable {
    let imageUrl: String
    
    init(map: Mapper) throws {
        try imageUrl = map.from("image_url")
    }
}
