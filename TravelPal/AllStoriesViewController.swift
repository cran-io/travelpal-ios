//
//  AllStoriesViewController.swift
//  TravelPal
//
//  Created by Totti on 5/6/16.
//  Copyright © 2016 Totti. All rights reserved.
//

import UIKit

class AllStoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var stories: [Story]!
    let dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        stories = Story.MR_findAll() as! [Story]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AllStoriesCell") as! AllStoriesTableViewCell
        let story = stories[indexPath.row]
        
        if let title = story.title {
            cell.storyTitle.text = title
        }
        
        if let category = story.category {
            cell.storyCategory.text = category
        }
        
        if let updatedAt = story.updatedAt {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.dateStyle = .ShortStyle
            cell.storyUpdated.text = dateFormatter.stringFromDate(updatedAt)
        }
        
        if let city = story.city?.name {
            cell.storyCity.text = city
        }
        
        if let author: String = "\(story.person!.name!) \(story.person!.lastName!)" {
            cell.storyAuthor.text = author
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("StoryVC") as? StoryViewController {
            vc.story = stories[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
