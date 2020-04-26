//
//  ProductTableViewCell.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    public var manager : CoreDataManager!
    var productTotal: ProductRequest!
    var delegate: ProductsTableView!
    var cartmanager = CartCoreDataManager()
    
    @IBOutlet weak var product: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addCart(_ sender: UIButton) {
      /*  let photos = ["prod1", "prod2", "prod3","prod4","prod5","prod1", "prod2", "prod3","prod4","prod5"]
        let names = ["Papas Lays", "Colombiana", "Arroz diana", "Arequipe", "Crema de leche", "Papas Lays", "Colombiana", "Arroz diana", "Arequipe", "Crema de leche"]
        let precios = [1204, 2000,450,245,900,8000,1000,2300,2400,1200]
        let opciones = [0,1]
        for  i in opciones {
            manager.createProduct(name : names[i], price : Double(precios[i]), sku : names[i], description : "Producto de alta calidad", photo : photos[i] )  {
                
            }*/
        print("add")
        cartmanager.addProductCart(container: manager.getContainer(), name: productTotal.name!, productf: productTotal, completion: {[weak self] in
             //2
             print("add2")
           // self?.delegate.updateUI()
            
            

            
        })
        
    }
    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

