//
//  StoryViewController.swift
//  TravelPal
//
//  Created by Totti on 5/5/16.
//  Copyright © 2016 Totti. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    
    var person: Person!
    var story: Story!
    
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var storyText: UITextView!
    @IBOutlet weak var storySubtitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = story.title
        
        storyImage.image = UIImage(named: "ciudad1")
        
        storyText.scrollRangeToVisible(NSRange(location:0, length:0))
        storyText.text = story.body
        storySubtitle.text = story.subTitle
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
