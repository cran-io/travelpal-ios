//
//  APIUtils.swift
//  TravelWithLocals
//
//  Created by Totti on 5/5/16.
//  Copyright © 2016 Totti. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIUtils {
    class func getAll() {
        self.getPersons()
        self.getCities()
    }
    
    class func getCities() {
        Alamofire.request(.GET, Constants.APIURL.CITIES_URL)
            .responseJSON { response in
                switch response.result {
                case .Success(let json):
                    let swiftyJSONObject = JSON(json)
                    CityUtils.saveCities(swiftyJSONObject)
                case .Failure(let error):
                    print("Error: \(error)")
                }
        }
    }
    
    class func getStories() {
        Alamofire.request(.GET, Constants.APIURL.STORY_URL)
            .responseJSON { response in
                switch response.result {
                case .Success(let json):
                    let swiftyJSONObject = JSON(json)
                    StoryUtils.saveStories(swiftyJSONObject)
                case .Failure(let error):
                    print("Error: \(error)")
                }
        }
    }

    class func getPersons() {
        Alamofire.request(.GET, Constants.APIURL.PERSONS_URL)
            .responseJSON { response in
                switch response.result {
                case .Success(let json):
                    let swiftyJSONObject = JSON(json)
                    PersonUtils.savePersons(swiftyJSONObject)
                case .Failure(let error):
                    print("Error: \(error)")
                }
        }
    }
}
