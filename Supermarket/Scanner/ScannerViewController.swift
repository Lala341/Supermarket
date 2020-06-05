//
//  ScannerViewController.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 31/05/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController , AVCaptureMetadataOutputObjectsDelegate, ScannerDelegate {

    
    public var manager: CoreDataManager!
    var cartmanager = CartCoreDataManager()
    var productsmaneger = ProductCoreDataManager()
    private var scanner: Scanner?
    var products = [ProductRequest]()
    var delegate: ProductsCartTableView!
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    self.scanner = Scanner(withDelegate: self)
    
    guard let scanner = self.scanner else {
        return
    }
    
    scanner.requestCaptureSessionStartRunning()
    loadProducts()
}
    override open var shouldAutorotate: Bool {
       return false
    }

    // Specify the orientation.
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .portrait
    }
     
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

// Mark - AVFoundation delegate methods
public func metadataOutput(_ output: AVCaptureMetadataOutput,
                           didOutput metadataObjects: [AVMetadataObject],
                           from connection: AVCaptureConnection) {
    guard let scanner = self.scanner else {
        return
    }
    scanner.metadataOutput(output,
                           didOutput: metadataObjects,
                           from: connection)
}

// Mark - Scanner delegate methods
func cameraView() -> UIView
{
    return self.view
}

func delegateViewController() -> UIViewController
{
    return self
}

func scanCompleted(withCode code: String)
{
    var encontrado = false
    print(code)
    for i in products{
        if(i.id==code){
            encontrado = true
            cartmanager.addProductCart(container: manager.getContainer(), name: i.name!, productf: i, completion: {[weak self] in
                 //2
                 print("add2")
                self!.delegate.updateAdd(e: encontrado)
                
            })
            
        }
    }
    if(encontrado == false){
        self.delegate.updateAdd(e: encontrado)
        
    }
        
    self.dismiss(animated: true, completion: {})
}
    private func loadProducts() {
        
        var produ: [ProductRequest] = []
        print("vowww")
        print(delegate.connection)
        if(delegate.connection){
        let url = URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8081/products")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
               
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                   let dataf = dataString.data(using: .utf8)!
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: dataf, options : .allowFragments) as? [Dictionary<String,Any>]
                        {
                           print(jsonArray) // use the json here

                            var temp : ProductRequest!
                            
                            for i in jsonArray{
                                print(i["name"]!)
                                temp = ProductRequest(name: i["name"]! as! String, price: Int(i["price"]! as! Double), sku: i["sku"]! as! String, descrip: i["description"]! as! String, photo:i["img_url"]! as! String, id: i["_id"]! as! String, store: i["store_id"]! as! Int, cantidad: 1 )
                                
                                produ.append(temp)
                                
                            }
                            self.products = produ
                            
                            
                            
                        } else {
                            print("bad json")
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
        }
        task.resume()
        }
        else{
        
            let productos:[Product] = productsmaneger.fetchProduts(container: manager.getContainer())
            
             
            for temp2 in productos{
                print(temp2)
                print(temp2.name!)
                print(Int(temp2.price))
                print(temp2.sku!)
                print(temp2.descrip!)
                print(temp2.photo!)
                let id = temp2.id ?? "prod1239"
                
                let temp = ProductRequest(name: temp2.name!, price: Int(temp2.price), sku: temp2.sku!, descrip: temp2.descrip!, photo: temp2.photo!, id: id , store: 1, cantidad: 1);
                produ.append(temp)
                
            }
        }
        self.products = produ
        
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
