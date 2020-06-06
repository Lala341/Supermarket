//
//  CoreDataManager.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation
import CoreData
class WishCoreDataManager {
    //2
  
    func fetchUserCart(container : NSPersistentContainer) -> WishList? {
        //1
        let fetchRequest : NSFetchRequest<WishList> = WishList.fetchRequest()
        
        do {
      
            //2
            let result = try container.viewContext.fetch(fetchRequest)
            
            if(result.count==0){
                return nil
            }
            
            return (result.last ?? WishList())
        } catch {
            print("El error obteniendo el carrito del usuario(s) \(error)")
         }
     
          //3
         return nil
    }
    func haveCart(container : NSPersistentContainer) -> Bool {
        //1
        let fetchRequest : NSFetchRequest<WishList> = WishList.fetchRequest()
        
        do {
      
            //2
            let result = try container.viewContext.fetch(fetchRequest)
            
            if(result.count==0){
                return false
            }
            
            return true
        } catch {
            print("El error obteniendo el carrito del usuario(s) \(error)")
         }
     
          //3
         return false
    }
    func cleanCart(container : NSPersistentContainer,  completion: @escaping() -> Void) {
        //1
        let fetchRequest : NSFetchRequest<WishList> = WishList.fetchRequest()
        
        do {
      
            //2
            let result = try container.viewContext.fetch(fetchRequest)
            
            if(result.count>0){
                result.last?.products = []
            }
            
            try container.viewContext.save()
            
           completion()
                       
        } catch {
            print("El error obteniendo el carrito del usuario(s) \(error)")
         }
     
          //3
completion()
        
        
    }
    func addProductCart(container : NSPersistentContainer, name : String, productf : ProductRequest,  completion: @escaping() -> Void) {
        // 2
        let context = container.viewContext
        
        let fetchRequest : NSFetchRequest<WishList> = WishList.fetchRequest()
        let fetchRequest2 : NSFetchRequest<Product> = Product.fetchRequest()
    
        
       
                
        
        do {
            
           let result = try context.fetch(fetchRequest )
        let result2 = try context.fetch(fetchRequest2)
            
            var final = Product()
            var ind=0
            while(ind<result2.count){
                if(result2[ind].name == productf.name){
                    final = result2[ind]
                    break
                }
                ind=ind+1
            }
            
            let final2 = result.last!
            let elements : [Product] = final2.products!.allObjects as! [Product]
            var j = 0
            var exist = false
            
            
            while(j<elements.count){
               if(elements[j].name == productf.name){
                    
                    elements[j].cantidad = elements[j].cantidad + Int16(productf.cantidad!)
                    exist = true
                    break
                }
                j = j + 1
            }
            
            if(exist == false){
                let product = Product(context: context)
                      product.name = productf.name
                      product.price = Double(productf.price!)
                      product.sku = productf.sku
                      product.descrip = productf.descrip
                      product.id = productf.id
                      product.photo = productf.photo
                      product.cantidad = Int16(productf.cantidad!)
                      
                product.wishList = final2
                final2.addToProducts(product)
            }
            else{
                 final.cantidad = final.cantidad + Int16(productf.cantidad!)
            }
            
            
            
            try context.save()
            
            completion()
        } catch {
         
          print("Error guardando producto — \(error)")
        }
    }
    func deleteProductCart(container : NSPersistentContainer, name : String, productf : Product,  completion: @escaping() -> Void) {
        // 2
        let context = container.viewContext
        
        let fetchRequest : NSFetchRequest<WishList> = WishList.fetchRequest()
        let fetchRequest2 : NSFetchRequest<Product> = Product.fetchRequest()
              
        
        do {
           let result = try context.fetch(fetchRequest )
        let result2 = try context.fetch(fetchRequest2)
            
            var final = result2.last!
            let final2 = result.last!
            let elements : [Product] = final2.products!.allObjects as! [Product]
            var ind=0
            while(ind<result2.count){
                if(elements[ind].name == productf.name){
                    final = elements[ind]
                    break
                }
                ind=ind+1
            }
            //final.WishList = final2
            
           if(final.cantidad == Int16(1)){
                final2.removeFromProducts(final)
            }else{
                
                final.cantidad = final.cantidad - Int16(1)
            }
            
            try context.save()
            
            completion()
        } catch {
         
          print("Error eliminando producto — \(error)")
        }
    }
    
}
