//
//  CityUtils.swift
//  TravelWithLocals
//
//  Created by Totti on 5/3/16.
//  Copyright © 2016 Totti. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import MagicalRecord

class CityUtils {
    class func saveCities(json: JSON) -> [City]? {
        if let stories = json.array {
            let arr = stories.map({ self.saveCity($0) })
            
            CoreDataUtils.saveCoreData()
            NSNotificationCenter.defaultCenter().postNotificationName("finishSavingCities", object: nil)
            return arr
        }
        return nil
    }
    
    class func saveCity(json: JSON) -> City{
        let city = City.MR_findFirstOrCreateByAttribute("id", withValue: json["id"].int!)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        if let id = json["id"].int {
            city.id = id
        }
        
        if let name = json["name"].string {
            city.name = name
        }
        
        if let country = json["country"].string {
            city.country = country
        }
        
        if let createdString = json["createdAt"].string {
            let createdAt = dateFormatter.dateFromString(createdString)
            city.createdAt = createdAt
        }
        
        if let updatedString = json["updatedAt"].string {
            let updatedAt = dateFormatter.dateFromString(updatedString)
            city.updatedAt = updatedAt
        }
        

        
//        if let pictures = json["pictures"].array {
//            let picturesArr = downloadPictures(pictures)
//            city?.images =
//        }
        
        return city
    }
    
//    class func downloadPictures(picturesArr: [JSON]) {
//        let downloader = ImageDownloader()
//        picturesArr.forEach({imageURL in
//            let url: String = "\(Constants.APIURL.ROOT_URL)/\(String(imageURL))"
//            let finalUrl = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
//            
//            
//        })
//    }
}