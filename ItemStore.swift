//
//  StepperStore.swift
//  GoGrabing
//
//  Created by Darshan,Bhavik, Madan, Farshad on 2020-03-22.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit
import CoreData

//Result enum for entity
enum ItemResult {
    case success([ShoppingItem])
    case failure(Error)
}

enum StoreResult {
    case success([ShoppingStore])
    case failure(Error)
}

//ItemStore
class ItemStore {

//    persistentContainer for SQLite
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GoGrabing")
        
        let appName: String = "GoGrabing"
        var persistentStoreDescriptions: NSPersistentStoreDescription
        
        let storeUrl = ItemStore.getDocumentsDirectory().appendingPathComponent("GoGrabing.sqlite")
        print(storeUrl)
        
        let description = NSPersistentStoreDescription()
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        description.url = storeUrl
        
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
//    Get SQLite file location
    static func getDocumentsDirectory()-> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
//    Fetch items from SQLite
    func fetchItems(completion: @escaping(ItemResult)->Void) {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ShoppingItem> = ShoppingItem.fetchRequest()
        managedContext.perform {
            do {
                let allItems = try managedContext.fetch(fetchRequest)
                completion(.success(allItems))
            } catch {
                print("failed")
                completion(.failure(error))
            }
        }
    }
    
//    Fetch Stores from SQLite
    func fetchStores(completion: @escaping(StoreResult)->Void) {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ShoppingStore> = ShoppingStore.fetchRequest()
        managedContext.perform {
            do {
                let allStores = try managedContext.fetch(fetchRequest)
                completion(.success(allStores))
            } catch {
                print("failed")
                completion(.failure(error))
            }
        }
    }
    
    
    
    func saveItem( itemName :String,storeName: String){
        let managedContext = persistentContainer.viewContext

//        create entity
        let entityItem =
          NSEntityDescription.entity(forEntityName: "ShoppingItem",
                                     in: managedContext)!
        
        let item = NSManagedObject(entity: entityItem,
                                     insertInto: managedContext)
        
        let entityStore =
        NSEntityDescription.entity(forEntityName: "ShoppingStore",
                                   in: managedContext)!
        var shoppingStore = NSManagedObject(entity: entityStore,
        insertInto: managedContext)
        
//        set information in entitys
        shoppingStore.setValue(Int.random(in: 0 ... 10000), forKey: "id")
        shoppingStore.setValue(storeName, forKey: "name")
        item.setValue(Int.random(in: 0 ... 10000), forKeyPath: "id")
        item.setValue(itemName, forKeyPath: "name")
        item.setValue(shoppingStore, forKeyPath: "shoppingStore")
        
        // save entity in coredata
        do {
          try managedContext.save()
            print("saved")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

