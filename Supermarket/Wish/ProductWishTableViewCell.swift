//
//  ProductTableViewCell.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class ProductWishTableViewCell: UITableViewCell {
    
    public var manager : CoreDataManager!

    var productTotal: Product!
    var cartmanager = WishCoreDataManager();
    var delegate: ProductsWishTableView!
    var delegatefinal: ProductsWishTableViewController!
    @IBOutlet weak var product: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var cant: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func removeCart(_ sender: UIButton) {
        cartmanager.deleteProductCart(container: manager.getContainer(), name: productTotal.name!, productf: productTotal, completion: {[weak self] in
         //2
         print("add2")
           
        self?.delegate.updateUI()
            self?.delegatefinal.actualizarTabla()
            
            
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
