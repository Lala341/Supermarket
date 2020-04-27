//
//  NotConection.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 19/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation
import UIKit
import Network

class NotConection: UIViewController {
    var counter = 0;
    public var manager: CoreDataManager!
    var usermanager = UserCoreDataManager();
    let networkMonitor = NWPathMonitor()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        
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



    


