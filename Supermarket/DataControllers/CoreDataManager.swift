//
//  CoreDataManager.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation
import CoreData
class CoreDataManager {
    //2
    private let container : NSPersistentContainer!
    //3
    init() {
        container = NSPersistentContainer(name: "Supermarket")
        
        setupDatabase()
    }
    
    private func setupDatabase() {
        //4
        container.loadPersistentStores { (desc, error) in
        if let error = error {
            print("Error loading store \(desc) — \(error)")
            return
        }
        print("Database ready!")
    }
}
    func deleteUsers() {
     
     //1
     let context = container.viewContext
     //2
     let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
     //3
     let deleteBatch = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
     do {
     
         //4
         try context.execute(deleteBatch)
         print("éxito borrando usuarios")
        }catch {
        print("Error Borrando los usuarios \(error)")
        }
    }
    func createUser(name : String, phone : String, email : String,gender : String, dateOfBirth : String, completion: @escaping() -> Void) {
        // 2
        let context = container.viewContext
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        let date = dateFormatter.date(from: dateOfBirth)
        let shoppy = ShoppingList(context: context)
        shoppy.name = "Cart"
        shoppy.tag = "Mercado"
        
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
    func fetchUsers() -> [User] {
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
    func fetchUser() -> User {
        //1
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        do {
      
            //2
            let result = try container.viewContext.fetch(fetchRequest)
            return result.last ?? <#default value#>
        } catch {
            print("El error obteniendo usuario(s) \(error)")
         }
     
          //3
         return User()
    }
    func createProduct(name : String, price : Int16, sku : String, description : String, photo : Data, completion: @escaping() -> Void) {
           // 2
           let context = container.viewContext
         
           
           let product = Product(context: context)
           product.name = name
           product.price = price
        product.sku = sku
        product.descrip = description
        product.photo = photo
           
           do {
               try context.save()
               print("Producto \(name) guardado")
               completion()
           } catch {
            
             print("Error guardando producto — \(error)")
           }
       }
       func fetchProduts() -> [Product] {
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
    func fetchProdutSku( sku : String ) -> Product {
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
            return result.last ?? <#default value#>
        } catch {
            print("El error obteniendo producto(s) \(error)")
         }
     
          //3
         return Product()
    }
    func fetchProdutName( name : String ) -> Product {
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
            return result.last ?? <#default value#>
        } catch {
            print("El error obteniendo producto(s) \(error)")
         }
     
          //3
         return Product()
    }
    
    
}
