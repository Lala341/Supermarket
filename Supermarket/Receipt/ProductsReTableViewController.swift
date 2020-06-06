//
//  ProductsReTableViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 5/06/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class ProductsReTableViewController: UITableViewController {
    
    public var manager : CoreDataManager!;
    var productmanager = ProductCoreDataManager();
    var cartmanager = CartCoreDataManager();
    var delegate: ProductsCartTableView!;
    var total: Double!;
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        actualizarTabla()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // updateUI()
              
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    var products : [Product]!

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cellIdentifier = "ProductReTableViewCell"
            let cell: ProductsReTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ProductsReTableViewCell

        cell.manager = manager
        cell.delegate = delegate
        let product = products[indexPath.row]
        // Configure the cell...
        var name: String!
        name = product.name
        cell.product.text = name  ?? "Colombina"
        var namep: String!
        namep = product.photo
        cell.photo.load(url: URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8082/images/\(namep!)")!, placeholder: cell.photo.image)
            
        cell.price.text =  "$ \(product.price)"
        cell.productTotal = product
        cell.cant.text = "\(product.cantidad)"
        return cell
    }
    @IBOutlet weak var cell: ProductTableViewCell!
    @IBOutlet weak var resumeCart:UIBarItem!
       
  
    func actualizarTabla(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
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
