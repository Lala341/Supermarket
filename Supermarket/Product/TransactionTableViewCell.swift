//
//  ProductTableViewCell.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    public var manager : CoreDataManager!
    var transactionTotal: TransactionRequest!
    var cartmanager = CartCoreDataManager()
    var usermanager = UserCoreDataManager();
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var payment: UILabel!
    @IBOutlet weak var value: UILabel!



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code}
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
// Configure the view for the selected state
    }
    
}

