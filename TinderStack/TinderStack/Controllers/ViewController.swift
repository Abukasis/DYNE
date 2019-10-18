//
//  ViewController.swift
//  TinderStack
//
//  Created by Osama Naeem on 16/03/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import UIKit
import Parse
import CoreData
class ViewController: UIViewController {

    //MARK: - Properties

    
    
    var viewModelData =  [CardsDataModel]()
    var stackContainer : StackContainerView!
  
    
    //MARK: - Init
    
    override func loadView() {
        let query = PFQuery(className:"Dinner")
        let bk = getBookMark()
        print(bk)
        query.whereKey("bookmark", equalTo: bk)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
               
                  
                for object in objects {
                    print(object.objectId as Any)
                    print(object["title"])
                    let title = object["title"] as! String
                    //***
                    if let imageFile : PFFileObject = object["image"] as? PFFileObject {
                        imageFile.getDataInBackground(block: { (data, error) in
                            if error == nil {
                                DispatchQueue.main.async {
                                    // Async main thread
                                    
                                    let image = UIImage(data: data!)
                                   
                                   
                                    
                                    self.viewModelData.append(CardsDataModel(bgColor: UIColor.white, text: title , image: image!))
                                    self.resetTapped()
                                }
                            } else {
                                print(error!.localizedDescription)
                            }
                        })
                    }
                
                    //***
                    
                    
                   
                }
                
            }
        }
        view = UIView()
        view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        stackContainer = StackContainerView()
        view.addSubview(stackContainer)
        configureStackContainer()
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        configureNavigationBarButtonItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DYNE"
        stackContainer.dataSource = self
        print(stackContainer.done)
        if stackContainer.done == true{
            loadView()
            stackContainer.done = false
        }
    }
    
 
    //MARK: - Configurations
    func configureStackContainer() {
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    func configureNavigationBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "My Recipes", style: .plain, target: self, action: #selector(cookBook))
    }
    
    @objc func cookBook(){
        let table = CookBook()
        
       
        self.show(table, sender: self)
    }
    
    //MARK: - Handlers
    @objc func resetTapped() {
        stackContainer.reloadData()
    }

    func makeBookMark(){
        
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Bookmark", in: context)!
        let newUser = NSManagedObject(entity: entity, insertInto: context)
        newUser.setValue(1, forKey: "bookmark")
        do {
            try context.save()
            
        } catch {
            print("Failed saving")
        }
    }
    
    func getBookMark() -> Int{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookmark")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if result.count == 0{
                makeBookMark()
                print("no saved ")
                return 1
            }
            for data in result as! [NSManagedObject] {
                print("here")
                var bookMark = data.value(forKey: "bookmark") as! Int
                print(bookMark)
                bookMark += 1
                print(bookMark)
                data.setValue(bookMark, forKey: "bookmark")
                if bookMark == 40{
                    data.setValue(1, forKey: "bookmark")
                }
                try context.save()
                return bookMark
            }
            
        } catch {
            makeBookMark()
            print("Failed")
            return 1
        }
        return getBookMark()
}
}
extension ViewController : SwipeCardsDataSource {

    func numberOfCardsToShow() -> Int {
        return viewModelData.count
    }
    
    func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = viewModelData[index]
        if(index == 48){
            viewDidLoad()
        }
        return card
    }
    
    func emptyView() -> UIView? {
        return nil
    }
    

}
