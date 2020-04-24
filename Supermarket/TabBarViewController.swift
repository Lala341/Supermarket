//
//  TabBarViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 24/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    var manager = CoreDataManager();
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
           else if segue.destination is NotConection
           {
               let vc = segue.destination as? NotConection
               vc?.manager = manager
           }
           else if segue.destination is MapViewController
           {
               let vc = segue.destination as? MapViewController
               vc?.manager = manager
           }
           
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
