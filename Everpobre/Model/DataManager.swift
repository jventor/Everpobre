//
//  CoreDataContainer.swift
//  Everpobre
//
//  Created by Jaime Ventor on 22/4/18.
//  Copyright © 2018 Jaime Ventor. All rights reserved.
//

import Foundation
import CoreData

//struct Container {
//  let static `default` = NSPersistentContainer(name: "Everpobre")
//}


//class DataManager: NSObject {
//  
//  static let sharedManager = DataManager()
//  
//  lazy var persistentContainer: NSPersistentContainer = {
//    
//    let container = NSPersistentContainer(name: "Everpobre")
//    container.loadPersistentStores(completionHandler: { (storeDescription,error) in
//      
//      if let err = error {
//        // Error to handle.
//        print(err)
//      }
//      container.viewContext.automaticallyMergesChangesFromParent = true
//    })
//    return container
//  }()
//
//}

struct Container {
  static var `default` : NSPersistentContainer = {
    let c = NSPersistentContainer(name: "Everpobre")
    c.loadPersistentStores { (description, error) in
      if let error = error {
        fatalError("No se ha podido cargar el modelo: \(error)")
      }
    }
    return c
  }()
}




