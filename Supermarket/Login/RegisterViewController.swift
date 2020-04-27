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
    
    var counter = 0;
    public var manager: CoreDataManager!
    var usermanager = UserCoreDataManager();
    let networkMonitor = NWPathMonitor()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        textName.delegate = self
        textPhone.delegate = self
        textEmail.delegate = self
        textGender.delegate = self
        textPassword.delegate = self
    }
    
    //MARK: prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is TabBarViewController
        {
            let vc = segue.destination as? TabBarViewController
            vc?.manager = manager
        }
            
        else if segue.destination is NotConection
        {
            let vc = segue.destination as? NotConection
            vc?.manager = manager
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
    @IBAction func createUser(_ sender: UIButton) {
        let name = textName.text ?? ""
        let phone = textPhone.text ?? ""
        let email = textEmail.text ?? ""
        let gender = textGender.text ?? ""
        let password = textPassword.text ?? ""
        let passwordSHA246 = sha256(password)
        
        let url = URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8083/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
        let parameters: [String: Any] = [
            "date_of_birth": "23/08/1998",
            "email": email,
            "gender": gender,
            "name": name,
            "phone": phone,
            "pass_hash": passwordSHA246
        ]
        let parametersJson = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.httpBody = parametersJson
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse, let data = data, let dataString = String(data: data, encoding: .utf8) {
                    if response.statusCode == 200 {
                        let dataJson = Data(dataString.utf8)
                        do {
                            // make sure this JSON is in the format we expect
                            if let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as? [String: Any] {
                                // try to read out a string array
                                print("json")
                                print(json)
                                if let id = json["_id"] as? String,
                                    let name = json["name"] as? String,
                                    let phone = json["phone"] as? String,
                                    let email = json["email"] as? String,
                                    let gender = json["gender"] as? String,
                                    let dateOfBirth = json["date_of_birth"] as? String{
                                    DispatchQueue.main.async {
                                        self.saveUser(id: id, name: name, phone: phone, email: email, gender: gender, dateOfBirth: dateOfBirth)
                                        self.goTabBarView()
                                    }
                                }else{
                                    print("ERRORRRRRRR!")
                                }
                            }
                        } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        task.resume()
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
        VC.manager = manager
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
        self.show(VC, sender: self)
    }
    
    func saveUser(id: String, name: String, phone: String, email: String, gender: String, dateOfBirth: String){
        print("Saving user in CoreData")
        usermanager.createUser(container: manager.getContainer(), id: id, name : name, phone : phone, email : email, gender : gender, dateOfBirth : "2020-12-01") { [weak self] in
            //2
            // self?.updateUI()
        }
    }
}
