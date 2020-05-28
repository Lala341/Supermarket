//
//  ProductsTableViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit
import Network

class ProductsTableView: UIViewController {
    
    public var manager: CoreDataManager!
    var cartmanager = CartCoreDataManager()
    var storeTotal: StoreRequest!
    var delegatetab: TabBarViewController!

    var element = false;
    @IBOutlet weak var data: UIButton!
    
    @IBOutlet weak var resumeCart: UIBarButtonItem!
    
    @IBAction func addCart(_ sender: UIButton) {
        element = true;
        data.setTitle("Almacenado", for: UIControl.State())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       //updateUI()
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.destination is ProductsTableViewController
        {
            let vc = segue.destination as? ProductsTableViewController
            vc?.manager = manager
            vc?.delegate = self
            vc?.storeTotal = storeTotal
            
            
        }
        if segue.destination is ProductsCartTableViewController
        {
            let vc = segue.destination as? ProductsCartTableViewController
            vc?.manager = manager
        }
    }
  
    func updateUI(){
    let ac = UIAlertController( title: "Done",  message: "Product added", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
       present(ac, animated: true)
    }

    

}
