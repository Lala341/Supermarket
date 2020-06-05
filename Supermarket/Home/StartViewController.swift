//
//  StartViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit
import Network

class StartViewController: UIViewController {
    var counter = 0;
    var manager = CoreDataManager();
    var usermanager = UserCoreDataManager();
    var productmanager = ProductCoreDataManager();
    let networkMonitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            if self.usermanager.haveUser(container: self.manager.getContainer()){
                self.nextTabBarView()
            } else {
                self.nextLoginView()
            }
        })
       do {
        
        networkMonitor.pathUpdateHandler = { path in
            
               if path.status == .satisfied {
                   print("Estás conectado a la red")
                if(self.topMostController() != nil && self.topMostController()! is NotConection){
                    DispatchQueue.main.async {
                                 self.topMostController()!.dismiss(animated: true, completion: {})
                        //self.topMostController()!.navigationController!.popToRootViewController( true)
                               }
                    
                    
                   
                    
                }
                else if(self.topMostController() != nil && self.topMostController()! is UITabBarController){
                    DispatchQueue.main.async {
                    let tab : UITabBarController = self.topMostController()! as! UITabBarController
                     
                    let m = tab.selectedIndex
                    let items = tab.tabBar.items
                        
                        (items![0] ).isEnabled = true
                        (items![1] ).isEnabled = true
                        (items![4] ).isEnabled = true
                        (items![0] ).badgeColor = .gray
                    
                        (items![1] ).badgeColor = .gray
                        (items![4] ).badgeColor = .gray
                        
                    if(m==2){
                        let Vf = tab.selectedViewController  as! ProductsCartTableView
                        Vf.connection = true
                        Vf.cone()
                    }
                    }
                    
                    
                }} else {
                   print("No estás conectado a la red")
               DispatchQueue.main.async {
                
                
                if(self.topMostController() != nil && self.topMostController()! is UITabBarController){
                    
                    let tab : UITabBarController = self.topMostController()! as! UITabBarController
                    let m = tab.selectedIndex
                    if(m == 2 ){
                        let items = tab.tabBar.items
                        
                        (items![0] ).isEnabled = false
                        (items![1] ).isEnabled = false
                        (items![4] ).isEnabled = false
                        let V = tab.selectedViewController  as! ProductsCartTableView
                        V.connection = false
                        
                        V.cone()
                        
                    }else if( m == 3){
                        let items = tab.tabBar.items
                        
                        (items![0] ).isEnabled = false
                        (items![1] ).isEnabled = false
                        (items![4] ).isEnabled = false
                        
                        let V = tab.selectedViewController  as! ProductsWishTableView
                        
                        
                    }else{
                        let VC = self.storyboard!.instantiateViewController(withIdentifier: "NotConnectionId") as! NotConection
                        VC.modalPresentationStyle = .fullScreen
                        
                                              
                        self.topMostController()!.present(VC,animated: true, completion: nil)
                    }
                    
                }else{
                    let VC = self.storyboard!.instantiateViewController(withIdentifier: "NotConnectionId") as! NotConection
                    VC.modalPresentationStyle = .fullScreen
                    
                                          
                    self.topMostController()!.present(VC,animated: true, completion: nil)
                }
                              
                           }
            
            }
           }

           let queue = DispatchQueue(label: "Network connectivity")
           networkMonitor.start(queue: queue)
            
        }
        catch  {
           print("Error — \(error)")
        }
        
    }
    func topMostController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return nil
        }

        var topController = rootViewController

        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }

        return topController
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
        
        else if segue.destination is MapViewController
        {
            let vc = segue.destination as? MapViewController
            vc?.manager = manager
        }
            
        else if segue.destination is LoginViewController
        {
            let vc = segue.destination as? LoginViewController
            vc?.manager = manager
        }
        
        
    }
    
    func nextTabBarView(){
        
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "TabBarView") as! TabBarViewController
        VC.manager = manager
        
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
        self.show(VC, sender: self)
        
    }
    
    func nextLoginView(){
        createre()
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
    @IBAction func createRecords(_ sender: UIButton) {
    
      
        let photos = ["prod1", "prod2", "prod3","prod4","prod5","prod1", "prod2", "prod3","prod4","prod5"]
        let names = ["Papas Lays", "Colombiana", "Arroz diana", "Arequipe", "Crema de leche", "Papas Lays", "Colombiana", "Arroz diana", "Arequipe", "Crema de leche"]
        let precios = [1204, 2000,450,245,900,8000,1000,2300,2400,1200]
        let opciones = [0,1,2,3,4,5,6,7,8,9]
        let i = opciones[0]
            productmanager.createProduct(container: manager.getContainer(), name : names[i], price : Double(precios[i]), sku : names[i], description : "Producto de alta calidad", photo : photos[i] )  {
                
            
            
        }
        
        
        }
    func createre()
    {
        let photos = ["prod1", "prod2", "prod3","prod4","prod5","prod1", "prod2", "prod3","prod4","prod5"]
        let names = ["Papas Lays", "Colombiana", "Arroz diana", "Arequipe", "Crema de leche", "Papas Lays", "Colombiana", "Arroz diana", "Arequipe", "Crema de leche"]
        let precios = [1204, 2000,450,245,900,8000,1000,2300,2400,1200]
        let opciones = [0,1,2,3,4,5,6,7,8,9]
        let i = opciones[0]
            productmanager.createProduct(container: manager.getContainer(), name : names[i], price : Double(precios[i]), sku : names[i], description : "Producto de alta calidad", photo : photos[i] )  {
                
            
            
        }
    }
    
    
    @IBAction func deleteRecords(_ sender: UIButton) {
        usermanager.deleteUsers(container: manager.getContainer())
        productmanager.deleteProducts(container: manager.getContainer())
        
    }
 /*     func updateUI() {
            //3
            counter = counter + 1
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


