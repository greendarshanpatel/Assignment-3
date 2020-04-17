//
//  StepperStore.swift
//  GoGrabing
//
//  Created by Student on 2020-04-17.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import Foundation

class StepperStore {

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GoGrabing")
        
        let appName: String = "GoGrabing"
        var persistentStoreDescriptions: NSPersistentStoreDescription
        
        let storeUrl = PhotoStore.getDocumentsDirectory().appendingPathComponent("GoGrabing.sqlite")
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
    
    
    
    func getStepper(){
        let fetchRequest: NSFetchRequest<Stepper> = Stepper.fetchRequest()
        
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            do {
                let allStepper = try viewContext.fetch(fetchRequest)
                completion(.success(allStepper))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

