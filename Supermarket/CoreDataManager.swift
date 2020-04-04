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
    func createUser(name : String, phone : String, email : String,gender : String, dateOfBirth : String, completion: @escaping() -> Void) {
        // 2
        let context = container.viewContext
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        let date = dateFormatter.date(from: dateOfBirth)
        
        let user = User(context: context)
        user.name = name
        user.phone = phone
        user.gender = gender
        user.email = email
        user.dateOfBirth = date
        
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
}
