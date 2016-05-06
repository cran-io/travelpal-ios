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
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AllPersonsCell") as! AllPersonsTableViewCell
        let person = persons[indexPath.row]
//        let now = NSDate()
//        let calendar = NSCalendar.currentCalendar()
//        let ageComponents = calendar.components(.Year, fromDate: person.birthdate!, toDate: now, options: NSCalendarOptions(rawValue: 0))
        let storiesCount = Story.MR_findByAttribute("personId", withValue: person.id!)
        cell.allName.text = "\(person.name!) \(person.lastName!)"
        cell.allProfession.text = "Profession: \(person.profession)"
        cell.allNationality.text = "Nationality: \(person.nationality)"
//        cell.allBirthdate.text = "Age: \(ageComponents)"
        cell.allStoriesCount.text = String(storiesCount?.count)
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
}
