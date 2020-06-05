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
    var delegatetab: TabBarViewController!
    var productsmanager = ProductCoreDataManager()
    var cartmanager = CartCoreDataManager()
    var agregado = false
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
    
    @IBAction func store() {
     print("storeTotal")
     
        print(storeTotal)
        if(agregado==false){
        let url = URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8081/stores/\(storeTotal.id!)/products")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
               
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                   let dataf = dataString.data(using: .utf8)!
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: dataf, options : .allowFragments) as? [Dictionary<String,Any>]
                        {
                           print(jsonArray) // use the json here

                            var temp : ProductRequest!
                            
                            for i in jsonArray{
                                print(i["name"]!)
                                temp = ProductRequest(name: i["name"]! as! String, price: Int(i["price"]! as! Double), sku: i["sku"]! as! String, descrip: i["description"]! as! String, photo:i["img_url"]! as! String, id: i["_id"]! as! String, store: i["store_id"]! as! Int, cantidad: 1 )
                                
                                self.productsmanager.addProduct(container:self.manager.getContainer(), produ: temp, completion: {} )
                                
                            }
                            
                            
                        } else {
                            print("bad json")
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
        }
        task.resume()
            self.agregado = true
        self.delegate.updateUIAdd();
        }else{
            self.delegate.updateUIAddya();
        }
    }
    
}

