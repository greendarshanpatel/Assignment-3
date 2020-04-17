//
//  StepperStore.swift
//  GoGrabing
//
//  Created by Student on 2020-04-17.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit
import CoreData


enum ItemResult {
    case success([ShoppingItem])
    case failure(Error)
}

enum StoreResult {
    case success([ShoppingStore])
    case failure(Error)
}

class ItemStore {

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
    
    static func getDocumentsDirectory()-> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func fetchItems(completion: @escaping(ItemResult)->Void) {
        
        print("called1")
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ShoppingItem> = ShoppingItem.fetchRequest()
        print("called2")
        managedContext.perform {
            do {
                let allItems = try managedContext.fetch(fetchRequest)
                print("called3")
                completion(.success(allItems))
            } catch {
                print("failed")
                completion(.failure(error))
            }
        }
    }
    
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

//        var storeFound : ShoppingStore? =  nil
//
//        self.fetchStores{
//            (result)-> Void in
//            switch result {
//            case let .success(stores):
//                for ShippingStore in stores {
//                    if storeName == ShippingStore.name {
//                        storeFound = ShippingStore
//                        break;
//                    }
//                }
//            case .failure:
//                print("failed")
//            }
//        }
        
        
        
        // 2
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
        
        
        shoppingStore.setValue(Int.random(in: 0 ... 10000), forKey: "id")
        shoppingStore.setValue(storeName, forKey: "name")
        item.setValue(Int.random(in: 0 ... 10000), forKeyPath: "id")
        item.setValue(itemName, forKeyPath: "name")
        item.setValue(shoppingStore, forKeyPath: "shoppingStore")
        
        
        // 3
        
//        if !(storeFound != nil){
           
//        }else{
//            shoppingStore = storeFound!
//        }

        
        

        // 4
        do {
          try managedContext.save()
            print("saved")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

