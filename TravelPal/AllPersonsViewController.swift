//
//  AllPersonsViewController.swift
//  TravelPal
//
//  Created by Totti on 5/6/16.
//  Copyright © 2016 Totti. All rights reserved.
//

import UIKit

class AllPersonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var persons: [Person]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        persons = Person.MR_findAll() as! [Person]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AllPersonsCell") as! AllPersonsTableViewCell
        let person = persons[indexPath.row]
        
        if let name = person.name {
            if let lastName = person.lastName {
                cell.allName.text = "\(name) \(lastName)"
            }
        }
        
        if let profession = person.profession {
            cell.allProfession.text = "Profession: \(profession)"
        }
        
        if let nationality = person.nationality {
            cell.allNationality.text = "Nationality: \(nationality)"
        }
        
        if let countStories = person.stories?.count {
            cell.allStoriesCount.text = "Stories: \(countStories)"
        }
        
        if let birthdate = person.birthdate {
            let dateFormatter = NSDateFormatter()
            let calendar = NSCalendar.currentCalendar()
            let now = NSDate()
            
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.dateStyle = .ShortStyle
            
            let ageComponents = calendar.components(.Year,
                                                    fromDate: birthdate,
                                                    toDate: now,
                                                    options: [])
            cell.allBirthdate.text = "Age: \(ageComponents.year)"
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("PersonVC") as? PersonViewController {
            vc.person = persons[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
