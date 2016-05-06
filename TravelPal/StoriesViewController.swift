//
//  StoriesViewController.swift
//  TravelPal
//
//  Created by Totti on 5/6/16.
//  Copyright © 2016 Totti. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var city: City!
    var stories: [Story]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        
        stories = Story.MR_findByAttribute("cityId", withValue: city.id!) as! [Story]
    }
    
    override func viewDidAppear(animated: Bool) {
        stories = Story.MR_findByAttribute("cityId", withValue: city.id!) as! [Story]
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    @IBAction func authorButtonPressed(sender: AnyObject) {
        let index = sender.tag
        let personId = stories[index].personId
        let person = Person.MR_findFirstByAttribute("id", withValue: personId!)
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("PersonVC") as? PersonViewController {
            vc.person = person
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Cant create person view")
        }
    }
    
    // MARK: TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 216
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StoriesCell") as! StoriesTableViewCell
        let story = stories[indexPath.row]
        let author = Person.MR_findFirstByAttribute("id", withValue: story.personId!)! as Person
        
        cell.storyTitle.text = story.title
        cell.storySubtitle.text = story.subTitle
        cell.storyCategory.setTitle(story.category, forState: .Normal)
        cell.storyPicture.image = UIImage(named: "person\(indexPath.row)")
        cell.storyAuthor.tag = indexPath.row
        
        cell.storyAuthor.setTitle("\(author.name!) \(author.lastName!)", forState: .Normal)
        cell.storyAuthor.sizeToFit()
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("StoryVC") as? StoryViewController {
            vc.story = stories[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}