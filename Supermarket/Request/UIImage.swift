//
//  ProductRequest.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 24/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//
import UIKit

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }

        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}
