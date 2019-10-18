//
//  CookBook.swift
//  TinderStack
//
//  Created by Oliver on 9/20/19.
//  Copyright © 2019 NexThings. All rights reserved.
//

import UIKit
import CoreData
import Parse

class CookBook: UITableViewController {
    var SavedTitles = [String]()
    var SavedPhotos = [UIImage]()
    var PicturesUp = false
    var thisTitle:String = ""
    

    
    func getSavedTitles() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Food")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            if result.count == 0{
               
                print("no saved ")
             
            }
            for data in result as! [NSManagedObject] {
                print("here")
                let title = data.value(forKey: "title") as! String
                SavedTitles.append(title)
                let pictureData = UIImage(data: data.value(forKey: "pic") as! Data)
                    
                SavedPhotos.append(pictureData!)
                
                
            }
            SavedPhotos.reverse()
            SavedTitles.reverse()
            
            
            
        }catch{
            print("failed")
           
        }
      
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()
        getSavedTitles()
        print("Saved Photos Count:" + String(SavedPhotos.count))
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "My")
        self.tableView.rowHeight = 130
        
        tableView.reloadData()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.SavedTitles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "My", for: indexPath)
        print(indexPath.row)
        print(SavedTitles.count)
        cell.textLabel!.text = SavedTitles[indexPath.row]
        cell.textLabel?.numberOfLines = 3
        if(indexPath.row < SavedPhotos.count){
            cell.imageView?.image = SavedPhotos[indexPath.row]
        }
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("YOU SELECTED ")
        print(indexPath.row)
        let this = tableView.cellForRow(at: indexPath) as! UITableViewCell
        self.thisTitle = this.textLabel!.text!
        let vc = Instructions()
        vc.itemTitle = thisTitle
        self.show(vc, sender: self)
    
    
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "instruct"){
            let vc = segue.destination as! Instructions
            vc.itemTitle = self.thisTitle
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
