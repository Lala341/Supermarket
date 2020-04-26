//
//  ProductsTableViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class ProductsWishTableView: UIViewController {
    
    public var manager: CoreDataManager!
    var cartmanager = CartCoreDataManager()
    var delegatetab: TabBarViewController!

    
    
@IBOutlet weak var resumeCart: UIBarButtonItem!
    @IBOutlet weak var table: UIView!
        @IBOutlet weak var imagee: UIImageView!
        @IBOutlet weak var buttone: UILabel!
        @IBAction func delete(){
            cartmanager.cleanCart(container: manager.getContainer(),  completion: {[weak self] in
             //2
             print("clean")
                self?.updateUI()
                self?.table.isHidden = true
    self?.imagee.isHidden = false
        self?.buttone.isHidden = false
            })
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUIIni()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      updateUIIni()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.destination is ProductsWishTableViewController
        {
            let vc = segue.destination as? ProductsWishTableViewController
            vc?.manager = manager
             vc?.delegate = self
            
        }
       
    }
   
 
    func updateUIIni() {
               //3
           let havecart = cartmanager.haveCart(container: manager.getContainer())
           
            
            print(havecart)
         
           var price : Double = 0
         if(havecart == true){
             let cart = cartmanager.fetchUserCart(container: manager.getContainer())
                print(cart)
             
             for i in cart!.products!
             {
              price = price + (i as! Product).price
                 
             }
         }
        if(price == 0){
             self.table.isHidden = true
             self.imagee.isHidden = false
             self.buttone.isHidden = false
             resumeCart.title = "Empty list."
         }else{
             self.table.isHidden = false
             self.imagee.isHidden = true
             self.buttone.isHidden = true
             resumeCart.title = "$ \(price)"
         }
             
          
       }
    func updateUI() {
            //3
        let havecart = cartmanager.haveCart(container: manager.getContainer())
        
         
         print(havecart)
      
        var price : Double = 0
      if(havecart == true){
          let cart = cartmanager.fetchUserCart(container: manager.getContainer())
             print(cart)
          
          for i in cart!.products!
          {
           price = price + (i as! Product).price
              
          }
      }
      if(price == 0){
          self.table.isHidden = true
          self.imagee.isHidden = false
          self.buttone.isHidden = false
          resumeCart.title = "Empty list."
      }else{
          self.table.isHidden = false
          self.imagee.isHidden = true
          self.buttone.isHidden = true
          resumeCart.title = "$ \(price)"
      }
            
        
      
      let ac = UIAlertController( title: "Done",  message: "Product removed", preferredStyle: .alert)
       ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    }

}
