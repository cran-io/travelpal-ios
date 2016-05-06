//
//  City+CoreDataProperties.swift
//  
//
//  Created by Totti on 5/5/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension City {

    @NSManaged var country: String?
    @NSManaged var createdAt: NSDate?
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var pictures: NSData?
    @NSManaged var picturesURL: String?
    @NSManaged var updatedAt: NSDate?
    @NSManaged var stories: NSSet?

}
