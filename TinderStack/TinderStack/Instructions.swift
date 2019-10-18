//
//  Instructions.swift
//  TinderStack
//
//  Created by Oliver on 9/20/19.
//  Copyright © 2019 NexThings. All rights reserved.
//

import UIKit
import Parse

class Instructions: UIViewController {
  
    var itemTitle:String = ""
 
    let scroll = UITextView()
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        scroll.sizeToFit()
        scroll.isEditable = false
        scroll.isHidden = false
        scroll.center = view.center
        scroll.bounds = view.bounds
        scroll.font = UIFont.boldSystemFont(ofSize: 16)
        setData()
        
        self.view.addSubview(self.scroll)

       
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setData(){
        let query = PFQuery(className:"Dinner")
        query.whereKey("title", equalTo: self.itemTitle)
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let objects = objects {
                print("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
               
                    print(objects[0].objectId as Any)
                    let object = objects[0]
                    let title = object["title"] as! String
                    let ingre = object["ingredients"] as! [String]
                    let steps = object["instructions"]  as! [String]
                    self.scroll.text += title
                    self.scroll.text += "\n \n"
                    self.scroll.text += "Ingredients:"
                    self.scroll.text += "\n \n"
                    for ing in ingre{
                        self.scroll.text += ing
                        self.scroll.text += "\n"
                    }
                    self.scroll.text += "\n"
                    self.scroll.text += "How to Cook:"
                    self.scroll.text += "\n"
                    var stepNumber = 1
                    for step in steps{
                        self.scroll.text += "Step " + String(stepNumber) + ":"
                        stepNumber += 1
                        self.scroll.text += "\n"
                        self.scroll.text += step
                        self.scroll.text += "\n \n"
                    }
                    
                
               
            }
        }
        
        
    }

}
