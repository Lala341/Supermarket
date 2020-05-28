//
//  ProductsTableViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//
import UIKit

class ProductsTableViewController: UITableViewController {
    
    public var manager: CoreDataManager!
    var cartmanager = CartCoreDataManager()
    var productmanager = ProductCoreDataManager()
    var products = [ProductRequest]()
    var delegate: ProductsTableView!
    var storeTotal: StoreRequest!
    var delegatetab: TabBarViewController!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .white
        loadProducts()
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    var indicator = UIActivityIndicatorView()

    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        indicator.transform = CGAffineTransform(scaleX: 2, y: 2);

        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?)
   {
       
    if  segue.identifier == "ShowProductDetail"{
    
    if let destination = segue.destination as? ProductDetailView {
        
        let blogIndex = tableView.indexPathForSelectedRow?.row
            
        let productTotal = self.products[blogIndex!]
               
              
               destination.manager = manager
                 destination.productTotal = productTotal
               destination.delegate = delegate
                     
         
        
        
        }
     }
   
       
   }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cellIdentifier = "ProductTableViewCell"
            let cell: ProductTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ProductTableViewCell

        cell.manager = manager
        cell.delegate = delegate
        let product = products[indexPath.row]
        // Configure the cell...
        print(product.price)
        print(String(describing: product.name) )
        var name: String!
        name = product.name
        cell.product.text = name  ?? "Colombina"
        var namep: String!
        namep = product.photo
        cell.photo.image = UIImage(url: URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8082/images/\(namep!)"))
        cell.price.text =  "$ \(product.price!)"
        
        cell.productTotal = product
        
        
        return cell
    }
    
    
    private func loadProducts() {
        
       // let produ = productmanager.fetchProduts(container: manager.getContainer())
       // products = produ
        print(storeTotal.id!)
        var produ: [ProductRequest] = []
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
                                
                                produ.append(temp)
                                
                            }
                            self.products = produ
                            print(self.products)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.indicator.stopAnimating()
                                self.indicator.hidesWhenStopped = true
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
