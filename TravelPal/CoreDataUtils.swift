//
//  CoreDataUtils.swift
//  TravelWithLocals
//
//  Created by Totti on 5/5/16.
//  Copyright © 2016 Totti. All rights reserved.
//

import Foundation
import MagicalRecord

class CoreDataUtils: NSObject {
    
    class func saveCoreData() {
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
}