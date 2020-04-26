//
//  ProductRequest.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 24/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation

class ProductRequest {
    
    var name: String?
    var price: Int?
    var sku: String?
    var descrip: String?
    var photo: String?
    var id: String?
    var store: Int?
    var cantidad: Int?
    
    init(name: String, price: Int, sku: String, descrip: String, photo: String, id: String, store: Int, cantidad: Int) { // Constructor
        self.name = name
        self.price = price
        self.sku = sku
        self.descrip = descrip
        self.photo = photo
        self.id = id
        self.store = store
        self.cantidad = cantidad
    }
    private enum CodingKeys: String, CodingKey {
        case store = "store_id"
        case id = "_id"
        case name = "name"
        case price = "price"
        case sku = "sku"
        case descrip = "description"
        case photo = "img_url"
    }

}
