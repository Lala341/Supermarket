//
//  LoginViewController.swift
//  Supermarket
//
//  Created by Luis Carlos Garavito Romero on 25/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation
import UIKit
import Network
import CryptoKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var warningLoginLabel: UILabel!
    
    var counter = 0;
    var manager = CoreDataManager();
    var usermanager = UserCoreDataManager();
    let networkMonitor = NWPathMonitor()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        do {
            networkMonitor.pathUpdateHandler = { path in
                
                if path.status == .satisfied {
                    print("Estás conectado a la red")
                    
                } else {
                    print("No estás conectado a la red")
                    
                    DispatchQueue.main.async {
                        let VC = self.storyboard!.instantiateViewController(withIdentifier: "NotConnectionId") as! NotConection
                        VC.modalPresentationStyle = .fullScreen
                        self.present(VC, animated: true, completion: nil)
                        
                        self.show(VC, sender: self)
                    }
                    
                }
            }
            
            let queue = DispatchQueue(label: "Network connectivity")
            networkMonitor.start(queue: queue)
        }catch{
            print("Error — \(error)")
        }
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
    @IBAction func loginActionButton(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let passwordSHA246 = sha256(password)
        
        let url = URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8083/users/login_user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
        let parameters: [String: Any] = [
            "email": email,
            "pass_hash": passwordSHA246
        ]
        let parametersJson = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.httpBody = parametersJson
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse, let data = data, let dataString = String(data: data, encoding: .utf8) {
                    if response.statusCode == 403 {
                        DispatchQueue.main.async {
                            self.warningLoginLabel.text = dataString
                        }
                    }
                    else if response.statusCode == 200 {
                        //TODO: Save the user_id from dataString
                        DispatchQueue.main.async {
                            self.goTabBarView()
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
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
        self.show(VC, sender: self)
    }
}
