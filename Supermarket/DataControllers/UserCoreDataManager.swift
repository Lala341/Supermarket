//
//  CoreDataManager.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation
import CoreData
class UserCoreDataManager {
    //2
    
    func deleteUsers(container : NSPersistentContainer) {
     
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
   
    func createUser(container : NSPersistentContainer, id: String, name : String, phone : String, email : String,gender : String, dateOfBirth : String, completion: @escaping() -> Void) {
        // 2
        let context = container.viewContext
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        let date = dateFormatter.date(from: dateOfBirth)
        let shoppy = ShoppingList(context: context)
        shoppy.name = "Cart"
        shoppy.tag = "Mercado"
        shoppy.products = []
        let wish = WishList(context: context)
        wish.name = "Cart"
        wish.tag = "Mercado"
        wish.products = []
        
        let user = User(context: context)
        user.id = id
        user.name = name
        user.phone = phone
        user.gender = gender
        user.email = email
        user.dateOfBirth = date
        user.shopList = shoppy
        user.wish = wish
        
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
    func haveUser(container : NSPersistentContainer) -> Bool {
        //1
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        do {
      
            //2
            let result = try container.viewContext.fetch(fetchRequest)
            
            if(result.count == 0){
                return false
            }
            return true
        } catch {
            print("El error obteniendo usuario(s) \(error)")
         }
     
          //3
         return false
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
   
    
    
}
