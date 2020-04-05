//
//  StartViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    var counter = 0
    private let manager = CoreDataManager()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var summaryLabel: UILabel!{
        didSet {
                   summaryLabel.text = "Registros en la base: \(0)\r\nÚltimo registro: nil"
        }
     }
    @IBAction func createRecords(_ sender: UIButton) {
     manager.createUser(name : "Laura", phone : "32037777", email : "li.forero@hotmail.com",gender : "femenino", dateOfBirth : "2020-12-01") { [weak self] in
               //2
               self?.updateUI()
            }
        }
    func updateUI() {
            //3
            counter = counter + 1
            let users = manager.fetchUsers()
            summaryLabel.text = "Último registro: \(users.last?.name)"
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
