//
//  Recommended.swift
//  mcommerce-ios
//
//  Created by lukasz on 19.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Mapper

struct Recommended: Mappable {
    let recommended: [Category]
    
    init(map: Mapper) throws {
        try recommended = map.from("recommended")
    }
}

