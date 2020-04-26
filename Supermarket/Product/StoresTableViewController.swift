//
//  ProductsTableViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//
import UIKit

class StoresTableViewController: UITableViewController {
    
    public var manager: CoreDataManager!
    var cartmanager = CartCoreDataManager()
    var productmanager = StoreCoreDataManager()
    var stores = [StoreRequest]()
    var delegate: StoresTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        loadProducts()
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
   

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stores.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cellIdentifier = "ProductTableViewCell"
            let cell: StoreTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! StoreTableViewCell

        cell.manager = manager
        cell.delegate = delegate
        let store = stores[indexPath.row]
        // Configure the cell...
        print(String(describing: store.name) )
        var name: String!
        name = store.name
        cell.product.text = name  ?? "Colombina"
        var namep: String!
        namep = store.photo
        cell.photo.image =  UIImage(named : namep ?? "prod1")
        cell.price.text =  store.address
        
        cell.storeTotal = store
        
        
        return cell
    }
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?)
          {
              
            if  segue.identifier == "ShowProducts",
                let destination = segue.destination as? ProductsTableView,
                let blogIndex = tableView.indexPathForSelectedRow?.row
            {
                destination.storeTotal = self.stores[blogIndex]
                destination.manager = manager
            }
          
              
          }
    
    private func loadProducts() {
        
       // let produ = productmanager.fetchProduts(container: manager.getContainer())
       // products = produ
        print("1")
        var stor: [StoreRequest] = []
        let url = URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8084/analytics/question3")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
               
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                   let dataf = dataString.data(using: .utf8)!
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[String: Any]]
                        {
                           print(jsonArray) // use the json here
                            var temp : StoreRequest!
                            var i = 1;
                            while( i < 7){
                                print(jsonArray["\(i)"]!["name"]!)
                                
                                
                                temp = StoreRequest(name: jsonArray["\(i)"]!["name"]! as? String, address: jsonArray["\(i)"]!["address"]! as! String, photo: "prod1", id: jsonArray["\(i)"]!["id"]! as! Int )
                                
                                stor.append(temp)
                                i = i + 1
                            }
                            self.stores = stor
                            print(self.stores)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
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
    }
   
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
