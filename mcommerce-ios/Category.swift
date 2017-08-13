//
//  Category.swift
//  mcommerce-ios
//
//  Created by lukasz on 13.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Mapper

struct Category: Mappable {
    let id: Int
    let name: String
    let description: String
    let parentId: Int?
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
        try description = map.from("description")
        parentId = map.optionalFrom("parent_id")
    }
}
