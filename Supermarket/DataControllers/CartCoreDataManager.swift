//
//  CoreDataManager.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation
import CoreData
class CartCoreDataManager {
    //2
  
    func fetchUserCart(container : NSPersistentContainer) -> ShoppingList? {
        //1
        let fetchRequest : NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        
        do {
      
            //2
            let result = try container.viewContext.fetch(fetchRequest)
            
            if(result.count==0){
                return nil
            }
            
            return (result.last ?? ShoppingList())
        } catch {
            print("El error obteniendo el carrito del usuario(s) \(error)")
         }
     
          //3
         return nil
    }
    func haveCart(container : NSPersistentContainer) -> Bool {
        //1
        let fetchRequest : NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        
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
        let fetchRequest : NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        
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
        
        let fetchRequest : NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        let fetchRequest2 : NSFetchRequest<Product> = Product.fetchRequest()
    
        
       
                
        
        do {
            try context.save()
            
           let result = try context.fetch(fetchRequest )
        let result2 = try context.fetch(fetchRequest2)
            
            var final = result2.last!
            for i in result2{
                if(i.name == productf.name){
                    final = i
                    
                }
            }
            let final2 = result.last!
            let elements : [Product] = final2.products!.allObjects as! [Product]
            var j = 0
            var exist = false
            for i in elements{
                if(i.name == productf.name){
                    
                    elements[j].cantidad = elements[j].cantidad + Int16(productf.cantidad!)
                    exist = true
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
                      
                final.shoppingList = final2
                final2.addToProducts(final)
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
        
        let fetchRequest : NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        let fetchRequest2 : NSFetchRequest<Product> = Product.fetchRequest()
              
        
        do {
           let result = try context.fetch(fetchRequest )
        let result2 = try context.fetch(fetchRequest2)
            
            var final = result2.last!
            let final2 = result.last!
            let elements : [Product] = final2.products!.allObjects as! [Product]
            for i in elements{
                if(i.name == productf.name){
                    final = i
                    
                }
            }
            //final.shoppingList = final2
            
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
