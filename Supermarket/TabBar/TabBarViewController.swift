//
//  TabBarViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 24/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
     public var manager : CoreDataManager!;
    var actualizadowish : Bool = false;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
           print("uno11")
           print(self.viewControllers)
        var uno = (self.viewControllers![0] as! MapViewController)
           uno.manager = manager
        
           print(uno.manager)
        
        
        let dos = (self.viewControllers![1] as! StoresTableView)
                  dos.manager = manager
                dos.delegatetab = self
        
        let tres = (self.viewControllers![2] as! ProductsCartTableView)
        tres.manager = manager
        tres.delegatetab = self
        
        let cuatro = (self.viewControllers![3] as! ProductsWishTableView)
        cuatro.manager = manager
        cuatro.delegatetab = self
        
        let cinco = (self.viewControllers![4] as! ProfileViewController)
        cinco.manager = manager
        // Do any additional setup after loading the view.
    }
    func changeAc(){
        if(self.actualizadowish == true){
            self.actualizadowish = false
        }else{
          self.actualizadowish = true
        }
        
        
    }
    func getAc() -> Bool{
        return self.actualizadowish
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
       {
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
