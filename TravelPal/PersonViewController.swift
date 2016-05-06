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
        
        self.title = "\(person.name!) \(person.lastName!)"
        
        self.personBrief.text = person.brief!
        self.personNationality.text = "Nationality: \(person.nationality!)"
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.dateStyle = .ShortStyle
        let birth = dateFormatter.stringFromDate(person.birthdate!)
        
        self.personBirthdate.text = "Birthdate: \(birth)"
        
        personPicture.image = UIImage(named: "person2")
        
        stories = Story.MR_findByAttribute("personId", withValue: person.id!) as! [Story]
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
        
    }
    
    @IBAction func twitterPressed(sender: AnyObject) {
        
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
        
        cell.personStoryTitle.text = story.title
        cell.personStorySubtitle.text = story.subTitle
        cell.personStoryCity.text = city.name
        cell.personStoryPicture.image = UIImage(named: "ciudad\(indexPath.row)")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
