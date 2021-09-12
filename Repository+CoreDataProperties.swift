//
//  Repository+CoreDataProperties.swift
//  
//
//  Created by Mac on 9/10/21.
//
//

import Foundation
import CoreData


extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }

    @NSManaged public var fullName: String
    @NSManaged public var id: Int32
    @NSManaged public var name: String

}
