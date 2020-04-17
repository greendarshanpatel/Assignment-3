//
//  Stepper+CoreDataProperties.swift
//  GoGrabing
//
//  Created by Student on 2020-04-17.
//  Copyright © 2020 GoGrabing. All rights reserved.
//
//

import Foundation
import CoreData


extension Stepper {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stepper> {
        return NSFetchRequest<Stepper>(entityName: "Stepper")
    }

    @NSManaged public var count: Int16

}
