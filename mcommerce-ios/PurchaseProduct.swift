//
//  PurchaseProduct.swift
//  mcommerce-ios
//
//  Created by lukasz on 26.08.2018.
//  Copyright © 2018 lukasz. All rights reserved.
//

import Mapper

struct PurchaseProduct: Mappable {
    let id: Int
    let purchaseId: Int
    let productId: Int
    let product: Product
    let price: Float
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try purchaseId = map.from("purchase_id")
        try productId = map.from("product_id")
        try product = map.from("product")
        try price = map.from("price")
    }
}
