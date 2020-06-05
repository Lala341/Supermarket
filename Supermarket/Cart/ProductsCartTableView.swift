//
//  ProductsTableViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class ProductsCartTableView: UIViewController{
    
    public var manager: CoreDataManager!
    var cartmanager = CartCoreDataManager()
    var usermanager = UserCoreDataManager()
    var delegatetab: TabBarViewController!
    var priceFinal = 0.0
    var adddone = false
    var adderror = false
    
@IBOutlet weak var resumeCart: UIBarButtonItem!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUIIni()
        cone()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIIni()
    cone()
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
            
            
        }
        if segue.destination is ProductsCartTableViewController
        {
            let vc = segue.destination as? ProductsCartTableViewController
            vc?.manager = manager
            vc?.delegate = self
        }
    }
    
    @IBOutlet weak var table: UIView!
    @IBOutlet weak var imagee: UIImageView!
    @IBOutlet weak var buttone: UILabel!
    
    @IBOutlet weak var connect: UILabel!
    var connection: Bool = true
    
    public func cone(){
        if(connection){
            self.connect.isHidden = true
        }else{
            self.connect.isHidden = false
        }
            
    }
    
    
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
    
  func updateUIIni() {
             //3
         let havecart = cartmanager.haveCart(container: manager.getContainer())
         
          
          
         var price : Double = 0
       if(havecart == true){
           let cart = cartmanager.fetchUserCart(container: manager.getContainer())
             
        var po : Product
           for i in cart!.products!
           {
            po = i as! Product
            price = price + (po.price*Double(po.cantidad))
               
           }
       }
    priceFinal = price
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
           
        if(adddone){
            adddone=false
           updateUIAdd()
        }
        if(adderror){
            adderror=false
            updateUIAddError()
        }
     }
  func updateUI() {
          //3
      let havecart = cartmanager.haveCart(container: manager.getContainer())
      
       
       
      var price : Double = 0
    if(havecart == true){
        let cart = cartmanager.fetchUserCart(container: manager.getContainer())
           
         var po : Product
                  for i in cart!.products!
                  {
                   po = i as! Product
                   price = price + (po.price*Double(po.cantidad))
                      
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

    @IBAction func scan() {
    print("voy");
        let VC = ScannerViewController();
        VC.modalPresentationStyle = .fullScreen
        VC.delegate = self
        VC.manager = manager
        self.present(VC,animated: true, completion: nil)

    
    }
    @IBAction func pay() {
    print("voypay");
        let VC = CheckoutViewController();
        VC.modalPresentationStyle = .fullScreen
        let user : User = usermanager.fetchUser(container: manager.getContainer())
        VC.email_user = user.email
        VC.id_user = user.id
        VC.total = priceFinal
        
        
        
        self.present(VC,animated: true, completion: nil)

    
    }
    
    func updateUIAdd(){
    let ac = UIAlertController( title: "Done",  message: "Product added", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
       present(ac, animated: true)
        
    }
    func updateUIAddError(){
    let ac = UIAlertController( title: "Not found",  message: "Product could not be found.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
       present(ac, animated: true)
        
    }
    func updateAdd(e: Bool){
        if(e){
           adddone=e
        }else{
            adderror=true
        }
        
    }

}
