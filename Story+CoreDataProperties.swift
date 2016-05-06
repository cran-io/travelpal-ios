//
//  Story+CoreDataProperties.swift
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

extension Story {

    @NSManaged var body: String?
    @NSManaged var category: String?
    @NSManaged var cityId: NSNumber?
    @NSManaged var createdAt: NSDate?
    @NSManaged var id: NSNumber?
    @NSManaged var personId: NSNumber?
    @NSManaged var title: String?
    @NSManaged var subTitle: String?
    @NSManaged var updatedAt: NSDate?
    @NSManaged var city: City?
    @NSManaged var person: Person?

}
