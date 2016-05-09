//
//  PersonUtils.swift
//  TravelPal
//
//  Created by Totti on 5/5/16.
//  Copyright © 2016 Totti. All rights reserved.
//

import Foundation
import Alamofire
import MagicalRecord
import SwiftyJSON

class PersonUtils {
    class func savePersons(json: JSON) -> [Person]? {
        if let persons = json.array {
            let arr = persons.map({ self.savePerson($0) })
            
            CoreDataUtils.saveCoreData()
            NSNotificationCenter.defaultCenter().postNotificationName("finishSavingPersons", object: nil)
            return arr
        }
        return nil
    }
    
    class func savePerson(json: JSON) -> Person {
        let person = Person.MR_findFirstOrCreateByAttribute("id", withValue: json["id"].int!)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let id = json["id"].int {
            person.id = id
        }
        
        if let name = json["name"].string {
            person.name = name
        }
        
        if let lastName = json["lastName"].string {
            person.lastName = lastName
        }
        
        if let profession = json["profession"].string {
            person.profession = profession
        }
        
        if let brief = json["brief"].string {
            person.brief = brief
        }
        
        if let nationality = json["nationality"].string {
            person.nationality = nationality
        }
        
        if let birthdateString = json["birthdate"].string {
            let birthdate = dateFormatter.dateFromString(birthdateString)
            person.birthdate = birthdate
        }
        
        if let twitter = json["twitter"].string {
            person.twitter = twitter
        }
        
        if let instagram = json["instagram"].string {
            person.instagram = instagram
        }
        
        if let createdString = json["createdAt"].string {
            let createdAt = dateFormatter.dateFromString(createdString)
            person.createdAt = createdAt
        }
        
        if let updatedString = json["updatedAt"].string {
            let updatedAt = dateFormatter.dateFromString(updatedString)
            person.updatedAt = updatedAt
        }
        
        if let pictures = json["pictures"].array {
            print(pictures)
        }
        
        print(person)
        
        return person
    }
}