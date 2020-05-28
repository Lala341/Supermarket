//
//  ProductRequest.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 24/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation

class TransactionRequest {
    
    var id : String?
    var date: String?
    var payment_type: String?
    var product_count: Int?
    var products: [ProductRequest]
    var store_id:Int?
    var total: Int?
    var user_age: Int?
    var user_id: String?
    
    init(id : String, date: String, payment_type: String, product_count: Int,
         products: [ProductRequest], store_id:Int, total: Int?, user_age: Int, user_id : String) { // Constructor
        self.id = id
         self.date = date
         self.payment_type = payment_type
         self.product_count = product_count
         self.products = products
         self.store_id = store_id
         self.total = total
         self.user_age = user_age
         self.user_id = user_id
         
    
    }
    

}
