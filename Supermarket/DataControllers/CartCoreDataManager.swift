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
  
    func fetchUserCart(container : NSPersistentContainer) -> ShoppingList {
        //1
        let fetchRequest : NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        
        do {
      
            //2
            let result = try container.viewContext.fetch(fetchRequest)
            
            
            return result.last ?? ShoppingList()
        } catch {
            print("El error obteniendo el carrito del usuario(s) \(error)")
         }
     
          //3
         return ShoppingList()
    }
    
    func addProductCart(container : NSPersistentContainer, name : String, productf : ProductRequest,  completion: @escaping() -> Void) {
        // 2
        let context = container.viewContext
        
        let fetchRequest : NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        let fetchRequest2 : NSFetchRequest<Product> = Product.fetchRequest()
    
        
        let shoppy = ShoppingList(context: context)
                  shoppy.name = "Cart"
                  shoppy.tag = "Mercado"
                  shoppy.products = []
                  
                  let product = Product(context: context)
        product.name = productf.name
        product.price = Double(productf.price!)
        product.sku = productf.sku
        product.descrip = productf.descrip
        product.id = productf.id
        product.photo = productf.photo
        product.shoppingList = shoppy
        product.cantidad = Int16(Int64(0))
        
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
            final.shoppingList = final2
            final2.addToProducts(final)
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
            for i in result2{
                if(i.name == productf.name){
                    final = i
                    
                }
            }
            let final2 = result.last!
            final.shoppingList = final2
            final2.removeFromProducts(final)
            try context.save()
            
            completion()
        } catch {
         
          print("Error eliminando producto — \(error)")
        }
    }
    
}
