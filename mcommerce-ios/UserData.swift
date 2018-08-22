//
//  User.swift
//  mcommerce-ios
//
//  Created by lukasz on 20.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Mapper

struct UserData: Mappable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try firstName = map.from("firstName")
        try lastName = map.from("lastName")
        try email = map.from("email")
    }
}
