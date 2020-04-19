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
     let networkMonitor = NWPathMonitor()

       
       
       override func viewDidLoad() {
           super.viewDidLoad()
           do{
           networkMonitor.pathUpdateHandler = { path in
                      
                         if path.status == .satisfied {
                             print("Estás conectado a la red")
                         
                         } else {
                             print("No estás conectado a la red")
                         
                         DispatchQueue.main.async {
                                        let VC = self.storyboard!.instantiateViewController(withIdentifier: "NotConnectionId") as! NotConection
                          VC.modalPresentationStyle = .fullScreen
                               
                           VC.manager = self.manager
                           
                           self.present(VC, animated: true, completion: nil)
                                                  
                                                  self.show(VC, sender: self)
                                     }
                      
                      }
                     }

                     let queue = DispatchQueue(label: "Network connectivity")
                     networkMonitor.start(queue: queue)
           } catch  {
              print("Error — \(error)")
           }
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
