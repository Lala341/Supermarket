//
//  ProductRequest.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 24/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation

class StoreRequest {
    
    var name: String?
    var address: String?
    var photo: String?
    var id: Int?
    var users: Int?
    
    init(name: String?, address: String?, photo:  String?, id: Int?, users: Int?) { // Constructor
        self.name = name
        self.address = address
        self.photo = photo
        self.id = id
        self.users = users
    }
    private enum CodingKeys: String, CodingKey {
        case store = "store_id"
        case id = "_id"
        case name = "name"
        case price = "price"
        case sku = "sku"
        case descrip = "description"
        case photo = "img_url"
        case users = "current_users"
    }

}
