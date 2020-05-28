//
//  ProductCodeable.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 24/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation

struct ProductRequest: Codable {
    
    let tweetRequestId: Int?
    let deviceToken: String?
    let hashtags: String?
    
    private enum CodingKeys: String, CodingKey {
        case tweetRequestId = "id"
        case deviceToken = "device_token"
        case hashtags
    }

}
