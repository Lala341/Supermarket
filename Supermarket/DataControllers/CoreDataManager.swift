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
        container = NSPersistentContainer(name: "Supermarket");
        
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
    public func getContainer() -> NSPersistentContainer{
     
        return container;
        
    }
    
    
    
}
