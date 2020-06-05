//
//  CoreDataManager.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation
import CoreData
class ProductCoreDataManager {
    //2

    func deleteProducts(container : NSPersistentContainer) {
     
     //1
     let context = container.viewContext
     //2
     let fetchRequest : NSFetchRequest<Product> = Product.fetchRequest()
     //3
     let deleteBatch = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
     do {
     
         //4
         try context.execute(deleteBatch)
         print("éxito borrando productos")
        }catch {
        print("Error Borrando los productos \(error)")
        }
    }
   
    func createUser(container : NSPersistentContainer, name : String, phone : String, email : String,gender : String, dateOfBirth : String, completion: @escaping() -> Void) {
        // 2
        let context = container.viewContext
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        let date = dateFormatter.date(from: dateOfBirth)
        let shoppy = ShoppingList(context: context)
        shoppy.name = "Cart"
        shoppy.tag = "Mercado"
        shoppy.products = []
        
        let user = User(context: context)
        user.name = name
        user.phone = phone
        user.gender = gender
        user.email = email
        user.dateOfBirth = date
        user.shopList = shoppy
        
        do {
            try context.save()
            print("Usuario \(name) guardado")
            completion()
        } catch {
         
          print("Error guardando usuario — \(error)")
        }
    }
    func fetchUsers(container : NSPersistentContainer) -> [User] {
        //1
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        do {
      
            //2
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print("El error obteniendo usuario(s) \(error)")
         }
     
          //3
         return []
    }
    func fetchUser(container : NSPersistentContainer) -> User {
        //1
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        
        do {
      
            //2
            let result = try container.viewContext.fetch(fetchRequest)
            
            return result.last ?? User()
        } catch {
            print("El error obteniendo usuario(s) \(error)")
         }
     
          //3
         return User()
    }
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
    func addProduct(container : NSPersistentContainer,produ: ProductRequest , completion: @escaping() -> Void) {
        // 2
        print("Producto \(produ.name) entroˇ")
        
        let context = container.viewContext
      
        let shoppy = ShoppingList(context: context)
        shoppy.name = "Cart"
        shoppy.tag = "Mercado"
        shoppy.products = []
        
        let product = Product(context: context)
        product.name = produ.name
       product.sku = produ.sku
        product.descrip = produ.descrip
     product.photo = produ.photo
     product.shoppingList = shoppy
        product.price = Double(produ.price!)
        product.cantidad = Int16(0)
        product.id = produ.id
        
        do {
         
            try context.save()
            print("Producto \(produ.name) guardado")
            completion()
        } catch {
         
          print("Error guardando producto — \(error)")
        }
    }
    func createProduct(container : NSPersistentContainer, name : String, price : Double, sku : String, description : String, photo : String , completion: @escaping() -> Void) {
           // 2
           let context = container.viewContext
         
           let shoppy = ShoppingList(context: context)
           shoppy.name = "Cart"
           shoppy.tag = "Mercado"
           shoppy.products = []
           
           let product = Product(context: context)
           product.name = name
           product.price = price
        product.sku = sku
        product.descrip = description
        product.photo = photo
        product.shoppingList = shoppy
           
           do {
            
               try context.save()
               print("Producto \(name) guardado")
               completion()
           } catch {
            
             print("Error guardando producto — \(error)")
           }
       }
       func fetchProduts(container : NSPersistentContainer) -> [Product] {
           //1
        
           let fetchRequest : NSFetchRequest<Product> = Product.fetchRequest()
           do {
         
               //2
               let result = try container.viewContext.fetch(fetchRequest)
               return result
           } catch {
               print("El error obteniendo producto(s) \(error)")
            }
        
             //3
            return []
       }
    func fetchProdutSku(container : NSPersistentContainer,  sku : String ) -> Product {
        //1
     
        let fetchRequest : NSFetchRequest<Product> = Product.fetchRequest()
        do {
            
      
            //2
            let result = try container.viewContext.fetch(fetchRequest)
            
            for i in result{
                if( i.sku == sku){
                    return i
                }
            }
            return result.last ?? Product()
        } catch {
            print("El error obteniendo producto(s) \(error)")
         }
     
          //3
         return Product()
    }
    func fetchProdutName(container : NSPersistentContainer,  name : String ) -> Product {
        //1
     
        let fetchRequest : NSFetchRequest<Product> = Product.fetchRequest()
        do {
            
      
            //2
            let result = try container.viewContext.fetch(fetchRequest)
            
            for i in result{
                if( i.name == name){
                    return i
                }
            }
            return result.last ?? Product()
        } catch {
            print("El error obteniendo producto(s) \(error)")
         }
     
          //3
         return Product()
    }
    
    
}
