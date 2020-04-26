//
//  ProductsTableViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//
import UIKit

class TransactionsTableViewController: UITableViewController {
    
    public var manager: CoreDataManager!
    var transactions = [TransactionRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .white
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        loadTransactions()
        
        
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
  

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transactions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cellIdentifier = "TransactionTableViewCell"
            let cell: TransactionTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TransactionTableViewCell

        cell.manager = manager
        let transactionTotal = transactions[indexPath.row]
        // Configure the cell...
        cell.transactionTotal = transactionTotal
        cell.name.text = transactionTotal.date
        cell.payment.text = transactionTotal.payment_type
        cell.value.text = "$ \(transactionTotal.total!)"
        print(transactionTotal )
        print(indexPath.row )
        print(transactions.count )
        
        return cell
    }
    
    
    private func loadTransactions() {
        
       // let produ = productmanager.fetchProduts(container: manager.getContainer())
       // products = produ
        var userid = "5ea075140757bccae7cbf5ca"
        var produ: [TransactionRequest] = []
        let url = URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8085/transactions/\(userid)")!
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

                            var temp : TransactionRequest!
                            
                            for i in jsonArray{
                                
                                let products: [ProductRequest] = []
                                temp = TransactionRequest(id : i["_id"] as! String, date: i["date"] as! String, payment_type: i["payment_type"] as! String, product_count: i["product_count"] as! Int,
                                                          products: products, store_id:i["store_id"] as! Int, total: i["total"] as! Int, user_age: i["user_age"] as! Int, user_id : i["user_id"] as! String)
                                
                                produ.append(temp)
                                
                            }
                            self.transactions = produ
                            print(self.transactions)
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
