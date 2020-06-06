//
//  ReceiptViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 5/06/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {

    var totalf: Double!
    var products : [Product]!

    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var taxes: UILabel!
    @IBOutlet weak var total: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subtotal.text = "$\(String(describing: totalf))"
        taxes.text = "$\(0)"
        total.text = "$\(String(describing: totalf))"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: {})
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        
        if segue.destination is ProductsReTableViewController
        {
            let vc = segue.destination as? ProductsCartTableViewController
            vc?.products = self.products
            
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
