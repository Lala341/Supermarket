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

class LoginViewController: UIViewController {
    var counter = 0;
    var manager = CoreDataManager();
    var usermanager = UserCoreDataManager();
    let networkMonitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
        
        let url2 = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        var request = URLRequest(url: url2)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
        let parameters: [String: Any] = [
            "username": "Mundo Cruel!!!"
        ]
        let parametersJson = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.httpBody = parametersJson
        let task2 = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task2.resume()
    }
    
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
    
    func nextView(){
        
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "TabBarView") as! TabBarViewController
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
        self.show(VC, sender: self)
        
    }
}
