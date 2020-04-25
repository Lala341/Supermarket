//
//  ProductTableViewCell.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {
    
    public var manager : CoreDataManager!
    var storeTotal: StoreRequest!
    var delegate: StoresTableView!

    var cartmanager = CartCoreDataManager()
    
    @IBOutlet weak var product: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    
    override func setSelected(_ selected: Bool, animated: Bool) {
     super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

