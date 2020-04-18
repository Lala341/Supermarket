//
//  CoreDataManager.swift
//  Supermarket
//
//  Created by Laura Isabella Forero Camacho on 4/04/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import Foundation
import CoreData
class TransactionCoreDataManager {
    
    
    func deleteTransacciones(container : NSPersistentContainer) {
     
     //1
     let context = container.viewContext
     //2
     let fetchRequest : NSFetchRequest<Transaction> = Transaction.fetchRequest()
     //3
     let deleteBatch = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
     do {
     
         //4
         try context.execute(deleteBatch)
         print("éxito borrando transacciones")
        }catch {
        print("Error Borrando las transacciones \(error)")
        }
    }
    
    
  func fetchTransacciones(container : NSPersistentContainer) -> [Transaction] {
      //1
      let fetchRequest : NSFetchRequest<Transaction> = Transaction.fetchRequest()
      do {
    
          //2
          let result = try container.viewContext.fetch(fetchRequest)
          return result
      } catch {
          print("El error obteniendo transacciones(s) \(error)")
       }
   
        //3
       return []
  }
}
