//
//  StoryUtils.swift
//  TravelPal
//
//  Created by Totti on 5/5/16.
//  Copyright © 2016 Totti. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import MagicalRecord

class StoryUtils {
    class func saveStories(json: JSON) -> [Story]? {
        if let stories = json.array {
            let arr = stories.map({ self.saveStory($0) })
            
            CoreDataUtils.saveCoreData()
            NSNotificationCenter.defaultCenter().postNotificationName("finishSavingStories", object: nil)
            return arr
        }
        return nil
    }
    
    class func saveStory(json: JSON) -> Story {
        let story = Story.MR_findFirstOrCreateByAttribute("id", withValue: json["id"].int!)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let id = json["id"].int {
            story.id = id
        }
        
        if let body = json["body"].string {
            story.body = body
        }
        
        if let title = json["title"].string {
            story.title = title
        }
        
        if let subTitle = json["subTitle"].string {
            story.subTitle = subTitle
        }
        
        if let category = json["category"].string {
            story.category = category
        }
        
        if let createdString = json["createdAt"].string {
            let createdAt = dateFormatter.dateFromString(createdString)
            story.createdAt = createdAt
        }
        
        if let updatedString = json["updatedAt"].string {
            let updatedAt = dateFormatter.dateFromString(updatedString)
            story.updatedAt = updatedAt
        }
        
        if let cityId = json["cityId"].int {
            story.cityId = cityId
        }
        
        if let personId = json["personId"].int {
            story.personId = personId
        }
        
        return story
    }
}
