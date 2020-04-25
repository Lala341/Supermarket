//
//  ProductRequest.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 24/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation

struct ProductRequest: Codable {
    
    let name: String?
    let price: Int?
    let sku: String?
    let descrip: String?
    let photo: String?
    let id: String?
    let store: Int?
    
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
