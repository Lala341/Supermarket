//
//  ProductTableViewCell.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class ProductDetailView:  UIViewController {
    
    public var manager : CoreDataManager!
    public var productTotal: ProductRequest!
    var delegate: ProductsTableView!
    var cartmanager = WishCoreDataManager()
    var delegatetab: TabBarViewController!


    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sku: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var descrip: UILabel!
    
    
   override func viewDidLoad() {
    super.viewDidLoad()
        // Initialization code
    self.name.text = productTotal.name
           self.sku.text = productTotal.sku
    self.price.text = "$ \(productTotal.price!)"
           self.descrip.text = productTotal.descrip
           self.image.image = UIImage(url: URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8082/images/\(productTotal.photo!)"))
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
            //self?.delegate.updateUI()
            let ac = UIAlertController( title: "Done",  message: "Product added", preferredStyle: .alert)
             ac.addAction(UIAlertAction(title: "OK", style: .default))
            self!.present(ac, animated: true)
            

            
        })
        
    }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
      
      
      if segue.destination is ProductsCartTableViewController
      {
          let vc = segue.destination as? ProductsCartTableViewController
          vc?.manager = manager
      }
  }
    
}

