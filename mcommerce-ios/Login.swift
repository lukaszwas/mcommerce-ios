//
//  Login.swift
//  mcommerce-ios
//
//  Created by lukasz on 20.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Mapper

struct Login: Mappable {
    let token: String
    let userId: Int
    let user: User
    
    init(map: Mapper) throws {
        try token = map.from("token")
        try userId = map.from("user_id")
        try user = map.from("user")
    }
}
