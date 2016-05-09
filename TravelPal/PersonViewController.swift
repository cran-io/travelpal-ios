//
//  PersonViewController.swift
//  TravelPal
//
//  Created by Totti on 5/6/16.
//  Copyright © 2016 Totti. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var personPicture: UIImageView!
    @IBOutlet weak var personBrief: UILabel!
    @IBOutlet weak var personNationality: UILabel!
    @IBOutlet weak var personBirthdate: UILabel!
    @IBOutlet weak var personInstagram: UIButton!
    @IBOutlet weak var personTwitter: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var person: Person!
    var stories: [Story]!
    let dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        stories = Story.MR_findByAttribute("personId", withValue: person.id!) as! [Story]
        
        if let name = person.name {
            if let lastName = person.lastName {
                self.title = "\(name) \(lastName)"
            }
        }
        
        if let brief = person.brief {
            self.personBrief.text = brief
        }
        
        if let nationality = person.nationality {
            self.personNationality.text = "Nationality: \(nationality)"
        }
        
        if let birthdate = person.birthdate {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.dateStyle = .ShortStyle
            let calendar = NSCalendar.currentCalendar()
            let now = NSDate()
            let ageComponents = calendar.components(.Year,
                                                    fromDate: birthdate,
                                                    toDate: now,
                                                    options: [])
            self.personBirthdate.text = "Age: \(ageComponents.year)"
        }
        
        personPicture.image = UIImage(named: "person2")
    }
    
    override func viewDidAppear(animated: Bool) {
        stories = Story.MR_findByAttribute("personId", withValue: person.id!) as! [Story]
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    @IBAction func instagramPressed(sender: AnyObject) {
        let instagram = "https://instagram.com/\(person.instagram!)"
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: instagram)!) {
            UIApplication.sharedApplication().openURL(NSURL(string: instagram)!)
        }
    }
    
    @IBAction func twitterPressed(sender: AnyObject) {
        let twitter = "https://twitter.com/\(person.twitter!)"
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: twitter)!) {
            UIApplication.sharedApplication().openURL(NSURL(string: twitter)!)
        }
    }
    
    // MARK: TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonStoriesCell") as! PersonStoriesTableViewCell
        let story = stories[indexPath.row]
        let city = City.MR_findFirstByAttribute("id", withValue: story.cityId!)! as City
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.dateStyle = .ShortStyle
        
        switch story.updatedAt {
        case nil:
            cell.personStoryUpdate.text = dateFormatter.stringFromDate(story.createdAt!)
        default:
            cell.personStoryUpdate.text = dateFormatter.stringFromDate(story.updatedAt!)
        }
        
        if let title = story.title {
            cell.personStoryTitle.text = title
        }
        
        if let subTitle = story.subTitle {
            cell.personStorySubtitle.text = subTitle
        }
        
        if let cityName = city.name {
            cell.personStoryCity.text = cityName
        }
        
        cell.personStoryPicture.image = UIImage(named: "ciudad\(indexPath.row)")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("StoryVC") as? StoryViewController {
            vc.story = stories[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Stories:"
    }
}
