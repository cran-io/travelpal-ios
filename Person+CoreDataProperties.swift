//
//  Person+CoreDataProperties.swift
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

extension Person {

    @NSManaged var birthdate: NSDate?
    @NSManaged var brief: String?
    @NSManaged var createdAt: NSDate?
    @NSManaged var id: NSNumber?
    @NSManaged var instagram: String?
    @NSManaged var lastName: String?
    @NSManaged var name: String?
    @NSManaged var nationality: String?
    @NSManaged var pictures: NSData?
    @NSManaged var picturesURL: String?
    @NSManaged var profession: String?
    @NSManaged var twitter: String?
    @NSManaged var updatedAt: NSDate?
    @NSManaged var stories: NSSet?

}
