//
//  HomeViewController.swift
//  TravelPal
//
//  Created by Totti on 5/5/16.
//  Copyright © 2016 Totti. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var cities: [City] = []
    var fCities: Bool = false
    var fPersons: Bool = false
    var fStories: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.212, green: 0.282, blue: 0.565, alpha: 1.00)
        self.title = "Travel"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        
        
        SVProgressHUD.setDefaultStyle(.Dark)
        SVProgressHUD.show()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.finishSavingCities), name: "finishSavingCities", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.finishSavingPersons), name: "finishSavingPersons", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.finishSavingStories), name: "finishSavingStories", object: nil)
    }
    
    func finishSavingCities() {
        fCities = true
        reloadData()
    }
    
    func finishSavingPersons() {
        fPersons = true
        reloadData()
    }
    
    func finishSavingStories() {
        fStories = true
        reloadData()
    }
    
    func reloadData(){
        if fPersons && fStories && fCities {
            cities = City.MR_findAll() as! [City]
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        cities = City.MR_findAll() as! [City]
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 216
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("StoriesVC") as? StoriesViewController {
            vc.city = cities[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cityCell") as! CityTableViewCell
        
        cell.cityImage.image = UIImage(named: "ciudad\(indexPath.row)")
        cell.cityImage.contentMode = .ScaleAspectFill
        cell.cityName.text = cities[indexPath.row].name
        cell.cityCountry.text = cities[indexPath.row].country
        cell.selectionStyle = .None
        
        return cell
    }
}
