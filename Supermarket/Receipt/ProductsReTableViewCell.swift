//
//  ProductsReTableViewCell.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 5/06/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class ProductsReTableViewCell: UITableViewCell {
    
    public var manager : CoreDataManager!

    var productTotal: Product!
    var cartmanager = CartCoreDataManager();
    var delegate: ProductsCartTableView!
     var delegatefinal: ProductsCartTableViewController!
    @IBOutlet weak var product: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var cant: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
