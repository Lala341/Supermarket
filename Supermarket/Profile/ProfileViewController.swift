//
//  StartViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit
import Network

class ProfileViewController: UIViewController {
    var counter = 0;
    public var manager: CoreDataManager!
    var usermanager = UserCoreDataManager();
    var productsmanager = ProductCoreDataManager();

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var dateb: UITextField!
    @IBOutlet weak var logout: UIButton!
    
       
       override func viewDidLoad() {
           super.viewDidLoad()
           self.logout.layer.cornerRadius = 10
           
        self.darTransaction()
        
           // Uncomment the following line to preserve selection between presentations
           // self.clearsSelectionOnViewWillAppear = false
           // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
           // self.navigationItem.rightBarButtonItem = self.editButtonItem
       }
    func darTransaction(){
        
        let users: [User] = usermanager.fetchUsers(container: manager.getContainer())
        if(users.count>0){
            let user = users[0]
            self.name.text = "Name: \(user.name!)"
        self.email.text = "Email: \(user.email!)"
        self.password.text = "Password: \(user.name!)"
        self.gender.text = "Gender: \(user.gender!)"
        self.phone.text = "Phone: \(user.phone!)"
            self.dateb.text = "Date of Birth: \(user.dateOfBirth!)"
        
        
        
        }
        
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
    @IBAction func addCart(_ sender: UIButton) {
        usermanager.deleteUsers(container: manager.getContainer())
        
        productsmanager.deleteProducts(container: manager.getContainer())
       let VC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewID") as! LoginViewController
       VC.manager = manager
       
       VC.modalPresentationStyle = .fullScreen
       self.present(VC, animated: true, completion: nil)
       self.show(VC, sender: self)
    
    
    }
    
  /*  @IBOutlet weak var summaryLabel: UILabel!{
        didSet {
                   summaryLabel.text = "Registros en la base: \(0)\r\nÚltimo registro: nil"
        }
     }
    */
    
 /*     func updateUI() {
            //3            counter = counter + 1
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
