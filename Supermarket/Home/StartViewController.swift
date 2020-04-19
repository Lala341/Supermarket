//
//  StartViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    var counter = 0;
    public let manager = CoreDataManager();
    var usermanager = UserCoreDataManager();
    var productmanager = ProductCoreDataManager();
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ProductsTableViewController
        {
            let vc = segue.destination as? ProductsTableViewController
            vc?.manager = manager
        }
        else if segue.destination is ProductsTableView
        {
            let vc = segue.destination as? ProductsTableView
            vc?.manager = manager
        }
        
    }
    
  /*  @IBOutlet weak var summaryLabel: UILabel!{
        didSet {
                   summaryLabel.text = "Registros en la base: \(0)\r\nÚltimo registro: nil"
        }
     }
    */
    @IBAction func createRecords(_ sender: UIButton) {
    
        usermanager.createUser(container: manager.getContainer(), name : "Laura", phone : "32037777", email : "li.forero@hotmail.com",gender : "femenino", dateOfBirth : "2020-12-01") { [weak self] in
               //2
              // self?.updateUI()
            }
        let photos = ["prod1", "prod2", "prod3","prod4","prod5","prod1", "prod2", "prod3","prod4","prod5"]
        let names = ["Papas Lays", "Colombiana", "Arroz diana", "Arequipe", "Crema de leche", "Papas Lays", "Colombiana", "Arroz diana", "Arequipe", "Crema de leche"]
        let precios = [1204, 2000,450,245,900,8000,1000,2300,2400,1200]
        let opciones = [0,1,2,3,4,5,6,7,8,9]
        for  i in opciones {
            productmanager.createProduct(container: manager.getContainer(), name : names[i], price : Double(precios[i]), sku : names[i], description : "Producto de alta calidad", photo : photos[i] )  {
                
            }
            
        }
        
        
        }
    
    
    
    @IBAction func deleteRecords(_ sender: UIButton) {
        usermanager.deleteUsers(container: manager.getContainer())
        productmanager.deleteProducts(container: manager.getContainer())
        
    }
 /*     func updateUI() {
            //3
            counter = counter + 1
            let users = usermanager.fetchUsers(container: manager.getContainer())
            summaryLabel.text = "Último registro añadido"
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
