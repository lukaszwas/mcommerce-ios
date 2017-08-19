//
//  Product.swift
//  mcommerce-ios
//
//  Created by lukasz on 14.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Mapper

struct Product: Mappable {
    let id: Int
    let name: String
    let description: String
    let categoryId: Int
    let price: Float
    let thumbnailUrl: String
    let category: Category?
    let images: [ProductImage]?
    let rates: [ProductRate]?
    let filterValues: [ProductFilterValue]?
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
        try description = map.from("description")
        try categoryId = map.from("category_id")
        try price = map.from("price")
        try thumbnailUrl = map.from("thumbnail_url")
        category = map.optionalFrom("category")
        images = map.optionalFrom("images")
        rates = map.optionalFrom("rates")
        filterValues = map.optionalFrom("filter_values")
    }
}
