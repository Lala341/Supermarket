//
//  RegisterViewController.swift
//  Supermarket
//
//  Created by Luis Carlos Garavito Romero on 26/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation
import UIKit
import Network
import CryptoKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textPhone: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textGender: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load!")
    }
    
    //MARK: prepare
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
    @IBAction func createUser(_ sender: UIButton) {
    }
    
    //MARK: Internal functions
    func sha256(_ data: String) -> String{
        let dataData = Data(data.utf8)
        let hashed = SHA256.hash(data: dataData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        return hashString
    }
    
    func goTabBarView(){
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "TabBarView") as! TabBarViewController
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
        self.show(VC, sender: self)
    }
}
